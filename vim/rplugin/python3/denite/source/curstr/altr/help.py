from denite.source.help import Source as Help


class Source(Help):
    def __init__(self, vim):
        super().__init__(vim)

        self.name = "curstr/altr/help"
        self.kind = "curstr/altr/help"
