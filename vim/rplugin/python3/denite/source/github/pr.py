import subprocess

from denite.source.base import Base


class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)

        self.name = "github/pr"
        self.kind = "github/pr"

        self.matchers = ["matcher_substring"]

    def gather_candidates(self, context):
        def create(line):
            pr_id = line.split()[0].replace("#", "")
            return {"word": line, "action__pr_id": pr_id}

        cmd = ["gh", "pr", "list", "--limit=50"]

        args = context["args"]
        if len(args) > 0:
            cmd.append(f"--assignee={args[0]}")
        if len(args) > 1:
            cmd.append(f"--status={args[1]}")

        process = subprocess.Popen(
            cmd, stdout=subprocess.PIPE, cwd=self.vim.call("getcwd")
        )
        prs = list(
            filter(lambda x: x, process.communicate()[0].decode("utf-8").split("\n"))
        )
        return [create(x) for x in prs]
