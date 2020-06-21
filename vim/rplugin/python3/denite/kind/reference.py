from denite.kind.file import Kind as File


class Kind(File):
    def __init__(self, vim):
        super().__init__(vim)

        self.name = "reference"
