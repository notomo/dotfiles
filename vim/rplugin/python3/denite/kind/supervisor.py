import subprocess

from denite.kind.word import Kind as Base


class Kind(Base):
    def __init__(self, vim):
        super().__init__(vim)

        self.name = "supervisor"

    def action_start(self, context):
        self.supervisorctl(context, "start")

    def action_stop(self, context):
        self.supervisorctl(context, "stop")

    def supervisorctl(self, context, action_name):
        for target in context["targets"]:
            subprocess.Popen(
                ["supervisorctl", action_name, target["word"]],
                cwd=target["action__cwd"],
            )
