import subprocess

from denite.base.kind import Kind as Base


class Kind(Base):
    def __init__(self, vim):
        super().__init__(vim)

        self.name = "github/pr"
        self.default_action = "view"

    def action_checkout(self, context):
        if len(context["targets"]) == 0:
            return
        pr_id = context["targets"][0]["action__pr_id"]
        cmd = ["gh", "pr", "checkout", pr_id]
        self.debug(" ".join(cmd))
        subprocess.Popen(cmd, cwd=self.vim.call("getcwd"))

    def action_view(self, context):
        ids = [x["action__pr_id"] for x in context["targets"]]
        for pr_id in ids:
            cmd = ["gh", "pr", "view", pr_id]
            self.debug(" ".join(cmd))
            subprocess.Popen(cmd, cwd=self.vim.call("getcwd"))
