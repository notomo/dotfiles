
from .base import Kind as Base


class Kind(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'completion'
        self.default_action = 'commandline_append'

        self.redraw_actions += ['commandline_append']
        self.persist_actions += ['commandline_append']

    def action_commandline_append(self, context):
        context['input'] = self.__get_command(context)

    def action_execute(self, context):
        self.__execute(context['input'])

    def action_append_and_execute(self, context):
        context['input'] = self.__get_command(context)
        self.__execute(context['input'])

    def __get_command(self, context):
        input_text = context['input']
        target = context['targets'][0]
        if input_text.endswith(' '):
            return '{}{} '.format(input_text, target['word'])

        inputs = input_text.split()[:-1]
        inputs.append(target['word'])
        return '{} '.format(' '.join(inputs))

    def __execute(self, command):
        self.vim.command(command)
