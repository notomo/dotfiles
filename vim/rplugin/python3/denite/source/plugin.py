
from .base import Base


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'plugin'
        self.kind = 'directory'
        self.matchers = ['matcher_substring']
        self.sorters = []

    def gather_candidates(self, context):
        plugins = (
            {
                'name': '/'.join(p['url'].split('/')[-2:]),
                'dir': p['dir']
            }
            for p
            in self.vim.call('minpac#getpluglist').values()
        )
        return [
            {
                'word': (
                    p['name']
                    if not p['name'].endswith('.git')
                    else p['name'][:-4]
                ),
                'action__path': p['dir'],
            } for p in plugins
        ]
