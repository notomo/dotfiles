
import os.path

from curstr.action_group.base import ActionGroup
from curstr.action_group.file import File
from curstr.action_group.nothing import Nothing
from curstr.options import Options

from .base import ActionFactory as Base


class ActionFactory(Base):

    def _create_action_group(self, options: Options) -> ActionGroup:
        path = self._vim.call('expand', '<cfile>')
        return self._get_action_group(path)

    def _get_action_group(self, path: str) -> ActionGroup:
        home = os.path.expanduser('~')
        absolute_path = path.replace('~', home)
        if not self.__validate_path(absolute_path):
            return Nothing(self._vim)
        return File(self._vim, absolute_path)

    def __validate_path(self, path: str) -> bool:
        if len(path) == 0:
            return False

        if not os.path.isfile(path):
            return False

        return True
