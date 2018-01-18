
import re
from functools import reduce

from .tag import Source as Tag


class Source(Tag):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'method'
        self.sorters = ['sorter_word']

    def gather_candidates(self, context):

        def unique(x, y):
            if y['word'] not in x:
                x[y['word']] = y
            return x

        class_path = context['args'][0].replace('/', '\\\\\\\\')

        candidates = []
        for candidate in super().gather_candidates(context):
            match = re.match(
                '\S+ \[(f|d)\].*(class|interface):{}$'.format(class_path),
                candidate['abbr']
            )
            if match is None:
                continue
            candidate['action__kind_name'] = match.group(1)
            candidate['abbr'] = '[{}]{}'.format(
                candidate['action__kind_name'],
                candidate['word']
            )
            candidates.append(candidate)

        return list(reduce(unique, candidates, dict()).values())
