from denite.kind.file import Kind as File


class Kind(File):
    def __init__(self, vim):
        super().__init__(vim)

        self.name = "highlight"

    def action_open(self, context):
        context["targets"] = self.targets(context)
        super().action_open(context)

    def action_tabopen(self, context):
        context["targets"] = self.targets(context)
        super().action_tabopen(context)

    def action_vsplit(self, context):
        context["targets"] = self.targets(context)
        super().action_vsplit(context)

    def action_split(self, context):
        context["targets"] = self.targets(context)
        super().action_split(context)

    def targets(self, context):
        return [x for x in context["targets"] if not len(x["action__path"]) == 0]
