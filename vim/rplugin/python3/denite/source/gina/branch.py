
from denite.source.base import Base


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'gina/branch'
        self.kind = 'gina/branch'

        self.matchers = ['matcher_substring']

    def gather_candidates(self, context):
        current_branch = self.vim.call('gina#component#repo#branch')

        def create(branch):
            is_current = branch == current_branch
            abbr = '* {}'.format(branch) if is_current else branch
            return {
                'word': branch,
                'abbr': abbr,
            }

        # HACK
        self.vim.command(
            'nnoremap <buffer> DeniteCompletionKey'
            ' :Gina branch <C-a>"<Home>echo"<CR>'
        )
        # HACK HACK HACK
        self.vim.api.command_output('normal DeniteCompletionKey')
        output = self.vim.api.command_output('normal DeniteCompletionKey')
        self.vim.command('unmap <buffer> DeniteCompletionKey')

        branches = output.split()[2:]
        if branches[-1:] == ['^A']:
            branches.pop()

        return [create(x) for x in branches]

    def highlight(self):
        self.vim.command('highlight default link myDeniteCurrent Type')

    def define_syntax(self):
        super().define_syntax()
        self.vim.command(
            'syntax match myDeniteCurrent /^\\s*\\*.*$/ '
            'contains=deniteMatchedRange'
        )
