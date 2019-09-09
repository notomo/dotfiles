from .base import Base


class Filter(Base):
    def __init__(self, vim):
        super().__init__(vim)

        self.name = "sorter_kind"
        self.description = "sort candidates by kind"

    def filter(self, context):
        return sorted(context["candidates"], key=lambda candidate: candidate["kind"])
