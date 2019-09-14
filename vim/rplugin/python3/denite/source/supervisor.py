import subprocess

from .base import Base


class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)

        self.name = "supervisor"
        self.kind = "supervisor"

    def gather_candidates(self, context):
        cmd = "supervisorctl status"

        project_path = self.vim.call(
            "notomo#vimrc#search_parent_recursive", "\\.git", "./"
        )
        if project_path == "":
            return []
        conf_path = self.vim.call("fnamemodify", project_path, ":h:h")

        def create(line):
            factors = line.split()
            return {"abbr": line, "word": factors[0], "action__cwd": conf_path}

        process = subprocess.Popen(
            cmd.split(" "), stdout=subprocess.PIPE, cwd=conf_path
        )
        raw_values = process.communicate()[0]
        lines = raw_values.decode("utf-8").strip().split("\n")
        if lines[0].endswith("refused connection"):
            return []

        return [create(line) for line in lines[:-1]]
