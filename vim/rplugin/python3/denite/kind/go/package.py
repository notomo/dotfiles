from denite.kind.directory import Kind as Directory


class Kind(Directory):
    def __init__(self, vim):
        super().__init__(vim)

        self.name = "go/package"
        self.default_action = "decls"

    def action_import(self, context):
        for target in context["targets"]:
            self.vim.command("GoImport {}".format(target["word"]))
