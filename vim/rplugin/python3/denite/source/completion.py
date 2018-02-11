
from .base import Base


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'completion'
        self.kind = 'completion'

        self.matchers = []
        self.sorters = []

    def gather_candidates(self, context):

        def create(completion):
            return {
                'word': completion
            }

        context['is_interactive'] = True

        input_text = context['input'].replace('"', '\\"')

        # HACK
        self.vim.command(
            'nnoremap <buffer> DeniteCompletionKey'
            ' :{}<C-a>"<Home>echo"<CR>'.format(input_text)
        )
        output = self.vim.api.command_output('normal DeniteCompletionKey')
        self.vim.command('unmap <buffer> DeniteCompletionKey')

        start = len(input_text.split()) - (
            0 if input_text.endswith(' ') else 1
        )
        if start < 0:
            start = 0

        # c_CTRL-A returns '^A' when nothing is completed.
        if output.endswith('^A'):
            output = output[:-2]

        completions = output.split()[start:]

        return [
            create(x) for x in completions
        ]
