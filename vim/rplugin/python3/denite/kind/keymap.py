
import re

from .base import Base


class Kind(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'keymap'
        self.default_action = 'execute'
        self.redraw_actions += ['delete', 'unmap']
        self.persist_actions += ['delete', 'unmap']

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
        lhs = re.sub('(?=^\\\\<Space>)', '1', lhs)

        command = 'normal {}'.format(lhs)
        self.vim.command('execute "{}"'.format(command))

    def action_delete(self, context):
        for target in context['targets']:
            # ex. mode = nox -> nunmap, ounmap, xunmap
            for mode in target['action__mode']:
                self.vim.command(
                    '{}unmap {}'.format(
                        mode,
                        target['action__lhs']
                    )
                )

    def action_unmap(self, context):
        # alias unmap=delete
        self.action_delete(context)
