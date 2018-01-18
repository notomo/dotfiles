
from .base import Base


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'option'
        self.kind = 'option'

    def gather_candidates(self, context):

        def create(option_name):
            value = self.vim.call('notomo#denite#get', option_name)
            return {
                'word': option_name,
                'abbr': 'set {}={}'.format(option_name, value)
            }

        return [
            create(option_name)
            for option_name
            # execlude "all"
            in self.vim.call('getcompletion', '*', 'option')[1:]
        ]
