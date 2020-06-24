import glob
import os

from denite.source.base import Base


class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)

        self.name = "go/src"
        self.kind = "go/src"

    def gather_candidates(self, context):

        home = os.path.expanduser("~")

        def get_path(src_path):
            # src/domain/user_name/package_name
            pattern = os.path.join(src_path, "*/*/*")
            isdir = os.path.isdir
            for path in glob.iglob(pattern):
                if not isdir(path):
                    continue
                yield path.replace(home, "~")

        go_path = os.getenv("GOPATH", os.path.join(home, "go"))
        src_path = os.path.join(go_path, "src")
        return [{"word": f, "action__path": f} for f in get_path(src_path)]
