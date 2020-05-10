from .base import Base


class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)

        self.name = "position"
        self.kind = "file"
        self.matchers = ["matcher_substring"]
        self.sorters = []

    def gather_candidates(self, context):
        args = []
        if len(context["args"]) > 0:
            args = context["args"]

        return [
            {
                "word": arg["path"],
                "action__path": arg["path"],
                "action__line": arg["line"],
                "action__col": arg["col"],
            }
            for arg in args
        ]
