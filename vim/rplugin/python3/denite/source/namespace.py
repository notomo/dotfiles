
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
            lambda x: re.match('\S+ \[(n|c)\]', x['abbr']) is not None,
            super().gather_candidates(context)
        ))

        for candidate in candidates:
            if re.match('\S+ \[n\]', candidate['abbr']) is not None:
                candidate['action__kind_name'] = 'n'
            else:
                candidate['action__kind_name'] = 'c'
                match = re.search('namespace:(\S+)', candidate['abbr'])
                if match:
                    candidate['word'] = '{}\\\\{}'.format(
                        match.group(1), candidate['word']
                    )
            candidate['abbr'] = candidate['word']

        return list(reduce(unique, candidates, dict()).values())
