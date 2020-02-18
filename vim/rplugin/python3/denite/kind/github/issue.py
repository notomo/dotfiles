import subprocess

from denite.base.kind import Kind as Base


class Kind(Base):
    def __init__(self, vim):
        super().__init__(vim)

        self.name = "github/issue"
        self.default_action = "view"

    def action_view(self, context):
        for target in context["targets"]:
            cmd = ["gh", "issue", "view", target["action__issue_id"]]
            if target["action__repo"]:
                cmd.append(f"--repo={target['action__repo']}")

            self.debug(" ".join(cmd))

            subprocess.Popen(cmd, cwd=self.vim.call("getcwd"))
