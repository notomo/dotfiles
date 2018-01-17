
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

        candidates = []
        for candidate in super().gather_candidates(context):
            match = re.match('\S+ \[(n|t|c|i)\]', candidate['abbr'])
            if match is None:
                continue
            candidate['action__kind_name'] = match.group(1)
            candidates.append(candidate)

        for candidate in candidates:
            match = re.search('namespace:(\S+)', candidate['abbr'])
            if match:
                candidate['word'] = '{}\\{}'.format(
                    match.group(1), candidate['word']
                )

            candidate['word'] = candidate['word'].replace('\\\\', '\\')

            candidate['abbr'] = '[{}] {}'.format(
                candidate['action__kind_name'], candidate['word']
            ).replace('\\\\', '\\')

        return list(reduce(unique, candidates, dict()).values())
