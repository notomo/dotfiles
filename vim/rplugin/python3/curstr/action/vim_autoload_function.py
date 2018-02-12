
import os.path
import re
from typing import Tuple

from curstr.target.file import File as Target

from .file import Action as File


class Action(File):

    def _find_target(self) -> Target:
        try:
            self._vim.command('setlocal iskeyword+={}'.format(':,<,>,#'))
            cword = self._vim.call('expand', '<cword>')
        finally:
            self._vim.command('setlocal iskeyword-={}'.format(':,<,>,#'))

        if '#' in cword:
            splited = cword.split('#')
            paths = splited[:-1]
            path = '{}.vim'.format(os.path.join('', *paths))
            for runtimepath in self._vim.options['runtimepath'].split(','):
                file_path = os.path.join(runtimepath, 'autoload', path)
                if os.path.isfile(file_path):
                    return Target(
                        file_path,
                        *self.__search_position(cword, file_path)
                    )
        elif cword.startswith('s:') or cword.startswith('<SID>'):
            return Target.current(
                self._vim,
                *self.__search_function_position(cword)
            )

        return Target()

    def executable(self) -> bool:
        return (
            super(Action, self).executable() and
            self._filetype_in('vim', 'python')
        )

    def __search_position(
        self, function_name: str, path: str
    ) -> Tuple[int, int]:
        with open(path, 'r') as f:
            line = f.readline()
            row = 1
            while line:
                match = re.match(
                    '\s*fu(nction)?!?\s*(?P<name>{})\('.format(function_name),
                    line
                )
                if match is not None:
                    return (row, match.start('name') + 1)
                line = f.readline()
                row += 1

        return (0, 0)

    def __search_function_position(self, name: str) -> Tuple[int, int]:
        match = re.match('(s:|<SID>)(?P<name>\S+)', name)
        function_name = match.group('name')
        return self._vim.call(
            'searchpos',
            '\\v\s*fu%[nction]!?\s*s:\zs{}\('.format(function_name),
            'nw'
        )
