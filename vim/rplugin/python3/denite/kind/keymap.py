
import re

from .base import Base


class Kind(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'keymap'
        self.default_action = 'execute'

    def action_execute(self, context):
        target = context['targets'][0]

        # execute only normal mode keymap
        if 'n' not in target['action__mode']:
            return

        # ex. <CR> -> \<CR>
        lhs = re.sub(
            '<(?=(.+)>)',
            '\<',
            target['action__lhs']
        )

        # ^\<Space> -> ^1\<Space>
        # help :normal
        lhs = re.sub('(?=^ )', '1', lhs)

        command = 'normal {}'.format(lhs)
        self.vim.command('execute "{}"'.format(command))
