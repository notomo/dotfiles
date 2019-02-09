
from denite.kind.base import Kind as Base


class Kind(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'gina/branch'
        self.default_action = 'checkout'

    def action_checkout(self, context):
        targets = context['targets']
        if not targets:
            return

        target = targets[0]
        self.vim.command('Gina! checkout {}'.format(target['word']))

    def action_track(self, context):
        targets = context['targets']
        if not targets:
            return

        target = targets[0]
        self.vim.command('Gina! checkout -t {}'.format(target['word']))

    def action_delete(self, context):
        branches = [t['word'] for t in context['targets']]
        if not branches:
            return

        self.vim.command('Gina! branch --delete {}'.format(' '.join(branches)))

    def action_activate(self, context):
        self.action_track(context)
