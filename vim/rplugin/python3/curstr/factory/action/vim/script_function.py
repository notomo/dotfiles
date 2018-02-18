
import re
from typing import Tuple

from curstr.action_group.base import ActionGroup
from curstr.action_group.nothing import Nothing
from curstr.action_group.position import Position
from curstr.factory.action.base import ActionFactory as Base
from curstr.options import Options


class ActionFactory(Base):

    def _create_action_group(self, options: Options) -> ActionGroup:
        try:
            self._vim.command('setlocal iskeyword+={}'.format(':,<,>'))
            cword = self._vim.call('expand', '<cword>')
        finally:
            self._vim.command('setlocal iskeyword-={}'.format(':,<,>'))

        position = self.__search_function_position(cword)
        if position != (0, 0):
            return Position(self._vim, *position)

        return Nothing(self._vim)

    def __search_function_position(self, name: str) -> Tuple[int, int]:
        match = re.match('(s:|<SID>)(?P<name>\S+)', name)
        if match is None:
            return (0, 0)
        function_name = match.group('name')
        return self._vim.call(
            'searchpos',
            '\\v\s*fu%[nction]!?\s*s:\zs{}\('.format(function_name),
            'nw'
        )
