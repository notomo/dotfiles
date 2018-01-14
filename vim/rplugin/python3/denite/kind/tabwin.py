
from .buffer import Kind as Buffer


class Kind(Buffer):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'tabwin'
        self.default_action = 'switch'
