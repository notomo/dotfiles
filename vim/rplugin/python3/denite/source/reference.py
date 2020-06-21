import glob
import os

from .base import Base


class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)

        self.name = "reference"
        self.kind = "reference"

    def gather_candidates(self, context):
        dir_path = "."
        if len(context["args"]) > 0:
            dir_path = context["args"][0]

        pattern = os.path.join(dir_path, "*.html")
        return [{"word": path, "action__path": path} for path in glob.iglob(pattern)]
