
from .base import Base


class Source(Base):

    MAP_FUNC_FORMAT = "call gina#custom#mapping#map('{}', '{}', '{}', '{}')"

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'gina_map'
        self.kind = 'word'

    def gather_candidates(self, context):

        def create(sheme, map_info):
            lhs = map_info[0]
            rhs = map_info[1]
            params = map_info[2]
            abbr = self.MAP_FUNC_FORMAT.format(
                sheme, lhs, rhs, params
            )
            return {
                'word': '{} {} {}'.format(scheme, lhs, rhs),
                'abbr': abbr,
            }

        schemes = [
            'blame', 'branch', 'changes', 'chaperon',
            'commit', 'grep', 'log', 'ls', 'patch',
            'reflog', 'stash', 'stash', 'status', 'tag'
        ]
        # TODO: combination
        # TODO: unique

        maps = []
        for scheme in schemes:
            maps.extend([
                create(scheme, map_info)
                for map_info
                in self.vim.call('gina#custom#preference', scheme)
                ['mapping']['mappings']
            ])

        return maps
