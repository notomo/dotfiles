
from denite.base.kind import Kind as Base


class Kind(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'alias'
        self.default_action = 'insert_to_terminal'

    def action_insert_to_terminal(self, context):
        target = context['targets'][0]
        self.vim.command('tab terminal')
        self.vim.call(
            'jobsend',
            self.vim.current.buffer.vars['terminal_job_id'],
            '{} '.format(target['action__terminal_command'])
        )
        self.vim.command('startinsert')
