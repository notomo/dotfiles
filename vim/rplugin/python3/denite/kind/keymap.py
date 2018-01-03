
from .base import Base


class Kind(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'keymap'
        self.default_action = 'execute'

    def action_execute(self, context):
        target = context['targets'][0]
        command = 'normal {}'.format(target['action__lhs'])
        # TODO mode validation
        # TODO expr
        self.vim.call('execute', command)
