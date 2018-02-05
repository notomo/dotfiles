
import os.path

from .file import Action as File


class Action(File):

    def __get_target_string(self) -> str:
        try:
            self._vim.command('setlocal iskeyword+={}'.format(':,<,>,#'))
            cword = self._vim.call('expand', '<cword>')
        finally:
            self._vim.command('setlocal iskeyword-={}'.format(':,<,>,#'))

        if '#' in cword:
            splited = cword.split('#')
            paths = splited[:-1]
            path = '{}.vim'.format(os.path.join('', *paths))
        else:
            # TODO: search script local
            path = ''

        # TODO: get position
        for runtimepath in self._vim.options['runtimepath'].split(','):
            file_path = os.path.join(runtimepath, 'autoload', path)
            if os.path.isfile(file_path):
                return file_path

        return ''

    def executable(self) -> bool:
        return (
            super(Action, self).executable() and
            self._vim.current.buffer.options['filetype'] in ('vim', 'python')
        )
