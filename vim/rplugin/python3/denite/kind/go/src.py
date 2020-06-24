import os

from denite.kind.directory import Kind as Directory


class Kind(Directory):
    def __init__(self, vim):
        super().__init__(vim)

        self.name = "go/src"

    def action_activate(self, context):
        home = os.path.expanduser("~")
        go_path = os.getenv("GOPATH", "~/go").replace(home, "~")
        src_path = os.path.join(go_path, "src/github.com/")
        for target in context["targets"]:
            path = target["word"].replace(src_path, "")
            self.vim.call("notomo#github#view_repo", path)
