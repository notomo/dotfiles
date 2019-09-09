import json
import os.path
import subprocess

from denite.source.base import Base


class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)

        self.name = "go/symbol"
        self.kind = "file"
        self.sorters = ["sorter_line_number"]

    def gather_candidates(self, context):
        relpath = os.path.relpath

        if len(context["args"]) > 0:
            path = context["args"][0]
        else:
            path = self.vim.call("expand", "%:p")

        result = self._execute(path)

        def create(line):
            file_name = relpath(line["filename"], path)
            return {
                "word": line["ident"],
                "abbr": "{} {}".format(file_name, line["full"]),
                "action__path": line["filename"],
                "action__line": line["line"],
                "action__col": line["col"],
            }

        return [create(line) for line in result]

    def _execute(self, path):
        command = ["motion", "-mode", "decls", "-include", "func,type", "-file", path]

        process = subprocess.Popen(command, stdout=subprocess.PIPE)
        output = process.communicate()[0].decode("ascii")
        try:
            result_json = json.loads(output, encoding="utf-8")
        except json.JSONDecodeError:
            return []

        if "decls" not in result_json:
            return []

        return result_json["decls"]

    def highlight(self):
        self.vim.command("highlight default link myDeclsKeyword Keyword")
        self.vim.command("highlight default link myDeclsType Type")
        self.vim.command("highlight default link myDeclsFile Comment")

    def define_syntax(self):
        super(Source, self).define_syntax()
        self.vim.command("syntax case match")
        self.vim.command("syntax keyword myDeclsKeyword type interface struct func ")
        self.vim.command(
            "syntax keyword myDeclsType chan map bool string error "
            "int int8 int16 int32 int64 rune byte "
            "uint uint8 uint16 uint32 uint64 uintptr "
            "float32 float64 complex64 complex128 "
        )
        self.vim.command("syntax case ignore")
        self.vim.command("syntax match myDeclsFile /^ [^[:space:]]*/ ")
