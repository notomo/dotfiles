from denite.kind.directory import Kind as Directory


class Kind(Directory):
    def __init__(self, vim):
        super().__init__(vim)

        self.name = "plugin"

    def action_update(self, context):
        for target in context["targets"]:
            name = target["word"].split("/")[-1]
            self.vim.call(
                "minpac#update",
                name,
                {"do": "call notomo#vimrc#update_rplugin_runtimepath()"},
            )

    def action_packadd(self, context):
        for target in context["targets"]:
            name = target["word"]
            self.vim.command(f"packadd {name}")

    def action_activate(self, context):
        for target in context["targets"]:
            self.vim.call("notomo#github#view_repo", target["word"])
