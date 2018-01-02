
import os.path

from .base import Base


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'runtimepath'
        self.kind = 'directory'
        self.matchers = ['matcher_substring']
        self.sorters = []

    def gather_candidates(self, context):
        home = os.path.expanduser('~')
        return [
            {
                'word': p.replace(home, '~') if p.startswith(home) else p,
                'action__path': p,
            } for p in self.vim.options['runtimepath'].split(',')
        ]
