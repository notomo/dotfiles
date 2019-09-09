import os

from denite.util import abspath

from .base import Base


class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)

        self.name = "dir_file"
        self.kind = "file"
        self.matchers = ["matcher_substring"]
        self.sorters = ["sorter_word", "sorter_kind"]

    def highlight(self):
        self.vim.command("highlight default link myDeniteDir String")

    def define_syntax(self):
        super(Source, self).define_syntax()
        self.vim.command(
            "syntax match myDeniteDir /^.*\/$/ contains=deniteMatchedRange"
        )

    def gather_candidates(self, context):
        if len(context["args"]) > 0:
            path = context["args"][0]
            to_abspath = lambda f: "{}/{}".format(path, f)
        else:
            path = context["path"]
            to_abspath = lambda f: abspath(self.vim, f)
        isdir = os.path.isdir
        return [
            {
                "word": f + ("/" if isdir(to_abspath(f)) else ""),
                "kind": ("directory" if isdir(to_abspath(f)) else "file"),
                "action__path": to_abspath(f),
            }
            for f in os.listdir(path)
        ]
