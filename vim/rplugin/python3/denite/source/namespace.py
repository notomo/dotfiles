
import re
from functools import reduce

from .tag import Source as Tag


class Source(Tag):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'namespace'
        self.kind = 'namespace'
        self.sorters = ['sorter_length', 'sorter_word']

    def gather_candidates(self, context):

        def unique(x, y):
            if y['word'] not in x:
                x[y['word']] = y
            return x

        candidates = list(filter(
            lambda x: re.match('\S+ \[(n|c|t)\]', x['abbr']) is not None,
            super().gather_candidates(context)
        ))

        for candidate in candidates:
            match = re.match('\S+ \[(n|c|t)\]', candidate['abbr'])
            kind = match.group(1)
            candidate['action__kind_name'] = kind

            if kind in 'nt':
                match = re.search('namespace:(\S+)', candidate['abbr'])
                if match:
                    candidate['word'] = '{}\\\\{}'.format(
                        match.group(1), candidate['word']
                    )

            candidate['abbr'] = '[{}] {}'.format(kind, candidate['word'])

        return list(reduce(unique, candidates, dict()).values())
