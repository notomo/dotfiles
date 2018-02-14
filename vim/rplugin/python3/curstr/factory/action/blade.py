
import os.path

from curstr.action_group.base import ActionGroup
from curstr.options import Options

from .file import ActionFactory as FileActionFactory


class ActionFactory(FileActionFactory):

    def _create_action_group(self, options: Options) -> ActionGroup:
        views_path = self._get_laravel_views_path()
        cfile = self._vim.call('expand', '<cfile>')
        path = '{}.blade.php'.format(
            os.path.join(views_path, *cfile.split('.'))
        )
        return self._get_action_group(path)

    def _get_laravel_views_path(self) -> str:
        path = self._vim.call('fnamemodify', './', ':p')
        for i in range(len(path.split('/')) - 2):
            views_path = os.path.join(path, 'resources/views', '')

            if os.path.isdir(views_path):
                return views_path

            path = os.path.join(
                self._vim.call('fnamemodify', path, ':h:h'), ''
            )

        return ''
