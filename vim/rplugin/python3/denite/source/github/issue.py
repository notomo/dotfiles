import subprocess

from denite.source.base import Base


class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)

        self.name = "github/issue"
        self.kind = "github/issue"

        self.matchers = ["matcher_substring"]

    def gather_candidates(self, context):

        cmd = ["gh", "issue", "list", "--limit=50"]

        repo = ""
        if "notomo_gh_repo" in self.vim.current.buffer.vars:
            repo = self.vim.current.buffer.vars["notomo_gh_repo"]
            cmd.append(f"--repo={repo}")

        def create(line):
            pr_id = line.split()[0].replace("#", "")
            return {"word": line, "action__issue_id": pr_id, "action__repo": repo}

        args = context["args"]
        if len(args) > 0:
            cmd.append(f"--assignee={args[0]}")
        if len(args) > 1:
            cmd.append(f"--status={args[1]}")

        self.debug(" ".join(cmd))
        process = subprocess.Popen(
            cmd, stdout=subprocess.PIPE, cwd=self.vim.call("getcwd")
        )
        issues = list(
            filter(lambda x: x, process.communicate()[0].decode("utf-8").split("\n"))
        )
        return [create(x) for x in issues]
