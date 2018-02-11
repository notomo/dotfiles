
from .base import Kind as Base


class Kind(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'denite_source'
        self.default_action = 'execute'

    def action_execute(self, context):
        args = [x['word'] for x in context['targets']]
        command = 'Denite {}'.format(' '.join(args))
        self.vim.command(command)
