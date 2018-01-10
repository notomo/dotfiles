

import re

from denite.util import split_input

from .base import Base


class Filter(Base):
    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'matcher_namespace'
        self.description = ''

    def filter(self, context):
        return list(filter(
            lambda x: re.match('\S+ \[n\]', x['abbr']) is not None,
            context['candidates']
        ))

    def convert_pattern(self, input_str):
        return '|'.join([re.escape(x) for x in split_input(input_str)])
