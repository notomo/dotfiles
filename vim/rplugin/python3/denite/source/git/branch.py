
import subprocess

from denite.source.base import Base


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'git/branch'
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

        cmd = ['git', 'branch', '--format', '%(refname:short)']
        if len(context['args']) == 1:
            cmd.append('--all')

        process = subprocess.Popen(
            cmd,
            stdout=subprocess.PIPE,
            cwd=self.vim.call('getcwd')
        )
        branches = list(filter(
            lambda x: x, process.communicate()[0].decode('ascii').split('\n')
        ))

        return [create(x) for x in branches]

    def highlight(self):
        self.vim.command('highlight default link myDeniteCurrent Type')

    def define_syntax(self):
        super().define_syntax()
        self.vim.command(
            'syntax match myDeniteCurrent /^\\s*\\*.*$/ '
            'contains=deniteMatchedRange'
        )
