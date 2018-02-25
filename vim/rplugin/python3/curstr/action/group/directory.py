
from .file import File


class Directory(File):

    def __init__(self, vim, path) -> None:
        super().__init__(vim, path)
