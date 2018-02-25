

from .base import Base


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'denite_source'
        self.kind = 'completion'

    def gather_candidates(self, context):
        return [
            {'word': 'Denite {}'.format(x)} for x in
            self.vim.call('denite#helper#_get_available_sources')
        ]
