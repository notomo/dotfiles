
import os.path

from curstr.target.file import File as Target

from .file import Action as File


class Action(File):

    def _find_target(self) -> Target:
        views_path = self._get_laravel_views_path()

        if not views_path:
            return Target()

        cfile = self._vim.call('expand', '<cfile>')
        path = '{}.blade.php'.format(
            os.path.join(views_path, *cfile.split('.'))
        )
        return Target(path)

    def executable(self) -> bool:
        return (
            super(Action, self).executable() and
            self._filetype_in('php', 'blade')
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
