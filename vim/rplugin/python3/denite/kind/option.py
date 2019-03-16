
from denite.base.kind import Kind as Base


class Kind(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'option'
        self.default_action = 'set_value'

        self.redraw_actions += ['set_default', 'set_value', 'toggle_value']
        self.persist_actions += ['set_default', 'set_value', 'toggle_value']

    def action_set_default(self, context):
        for target in context['targets']:
            self.vim.command('set {}&'.format(target['word']))

    def action_set_value(self, context):
        value = self.vim.call('input', 'Value :', '\x02')
        for target in context['targets']:
            self.vim.command('set {}={}'.format(target['word'], value))

    def action_toggle_value(self, context):
        for target in context['targets']:
            self.vim.command('set {}!'.format(target['word']))
