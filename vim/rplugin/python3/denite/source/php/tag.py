
import re
from functools import reduce

from denite.source.tag import Source as Tag


class Source(Tag):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'php/tag'
        self.sorters = ['sorter_word']

    def gather_candidates(self, context):

        def unique(x, y):
            if y['word'] not in x:
                x[y['word']] = y
            return x

        class_path = context['args'][0]
        attribute = context['args'][1]
        namespace = '\\\\\\\\'.join(class_path.split('/')[:-1])
        class_name = class_path.split('/')[-1]
        class_path = class_path.replace('/', '\\\\\\\\')

        if attribute != '':
            pattern = '{}\s\[(f|d|v)\].*(trait|class|interface):{}'.format(
                attribute, class_path
            )
            action_pattern = '.*function.*\zs{}\ze'.format(attribute)
        else:
            pattern = '{}\s\[(t|c|i)\].*namespace:{}'.format(
                class_name, namespace
            )

        candidates = []
        for candidate in super().gather_candidates(context):
            match = re.match(pattern, candidate['abbr'])
            if match is None:
                continue
            candidate['action__kind_name'] = match.group(1)
            candidate['abbr'] = '[{}]{}'.format(
                candidate['action__kind_name'],
                candidate['word']
            )
            if attribute != '':
                candidate['action__pattern'] = action_pattern
            candidates.append(candidate)

        return list(reduce(unique, candidates, dict()).values())
