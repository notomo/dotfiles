import subprocess

from denite.kind.word import Kind as Base


class Kind(Base):
    def __init__(self, vim):
        super().__init__(vim)

        self.name = "proc"

        self.redraw_actions += ["kill"]
        self.persist_actions += ["kill"]

    def action_kill(self, context):
        pids = [x["action__pid"] for x in context["targets"]]
        subprocess.Popen(["kill", " ".join(pids)])
