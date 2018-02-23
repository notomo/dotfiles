
import os.path

from curstr.action_group.base import ActionGroup
from curstr.action_group.directory import Directory
from curstr.action_group.nothing import Nothing
from curstr.options import Options

from .base import ActionFactory as Base


class ActionFactory(Base):

    def _create_action_group(self, options: Options) -> ActionGroup:
        path = self._vim.call('expand', '<cfile>')
        return self._get_action_group(path)

    def _get_action_group(self, path: str) -> ActionGroup:
        absolute_path = self._vim.call('fnamemodify', path, ':p')
        if not os.path.isdir(absolute_path):
            return Nothing(self._vim)
        return Directory(self._vim, absolute_path)
