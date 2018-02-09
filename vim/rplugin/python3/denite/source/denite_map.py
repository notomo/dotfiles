
from .base import Base


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'denite_map'
        self.kind = 'word'

    def gather_candidates(self, context):

        def create(mode, map_info):
            lhs = map_info[0]
            rhs = map_info[1]
            params = map_info[2]
            abbr = "call denite#custom#map('{}', '{}', '{}', '{}')".format(
                mode, lhs, rhs, params
            )
            return {
                'word': '{} {}'.format(lhs, rhs),
                'abbr': abbr,
            }

        maps = []
        for mode, map_infos in context['custom']['map'].items():
            maps.extend([create(mode, map_info) for map_info in map_infos])

        return maps
