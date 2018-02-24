
import os.path

from curstr.action_group.base import ActionGroup
from curstr.action_group.file import File
from curstr.action_group.nothing import Nothing
from curstr.custom import ActionSourceOption

from .base import ActionFactory as Base


class ActionFactory(Base):

    def _create_action_group(self, option: ActionSourceOption) -> ActionGroup:
        path = self._vim.call('expand', '<cfile>')
        return self._get_action_group(path)

    def _get_action_group(self, path: str) -> ActionGroup:
        absolute_path = self._vim.call('fnamemodify', path, ':p')
        if not os.path.isfile(absolute_path):
            return Nothing(self._vim)
        return File(self._vim, absolute_path)
