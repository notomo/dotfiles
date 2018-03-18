
import os.path

from curstr.action.group import ActionGroup, FileDispatcher
from curstr.custom import SourceOption

from .base import Source as Base


class Source(Base):

    DISPATCHER_CLASS = FileDispatcher

    def create(self, option: SourceOption) -> ActionGroup:
        views_path = self._get_laravel_views_path()
        cfile = self._vim.call('expand', '<cfile>')
        path = '{}.blade.php'.format(
            os.path.join(views_path, *cfile.split('.'))
        )
        return self._dispatcher.dispatch_one(
            FileDispatcher.File, path
        )

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
