
import os.path

from .base import Base


class Source(Base):

    PATHS = [
        '~/.vim/minpac/pack/minpac/start/gesture.nvim',
        '~/.vim/minpac/pack/minpac/start/ctrlb.nvim',
        '~/.vim/minpac/pack/minpac/start/curstr.nvim',
        '~/.vim/minpac/pack/minpac/start/vimonga',
        '~/workspace/lsync/ctrlb',
        '~/workspace/mapemo',
        '~/go/src/github.com/notomo/wsxhub/',
        '~/.local/share/nvim/rplugin.vim',
        '/tmp/ctrlb.log',
        '/tmp/gesture.log',
        '/tmp/qaper',
        '~/dotfiles/vim/rc/local/local.vim',
        '~/.local/.bashrc',
        '~/.local/.bash_profile',
        '~/.local/.denite_file_bookmark',
        '~/.local/.denite_go_package',
    ]

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'file_bookmark'
        self.kind = 'file'
        self.matchers = ['matcher_substring']
        self.sorters = []

    def highlight(self):
        self.vim.command('highlight default link myDeniteDir String')

    def define_syntax(self):
        super(Source, self).define_syntax()
        self.vim.command(
            'syntax match myDeniteDir /^.*\\/$/ contains=deniteMatchedRange'
        )

    def gather_candidates(self, context):
        paths = self.PATHS.copy()

        file_path = os.path.expanduser('~/.local/.denite_file_bookmark')
        if not os.path.isfile(file_path):
            with open(file_path, 'a'):
                pass

        path_file = open(file_path, 'r')
        paths.extend([path.rstrip() for path in path_file])
        path_file.close()

        isdir = os.path.isdir
        join = os.path.join
        return [
            {
                'word': join(path, '') if isdir(path) else path,
                'kind': 'directory' if isdir(path) else 'file',
                'action__path': path,
            } for path in filter(
                lambda x: os.path.exists(x),
                [os.path.expanduser(p) for p in paths]
            )
        ]
