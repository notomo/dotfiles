
import os.path

from .file import Action as File


class Action(File):

    def __get_target_string(self) -> str:
        views_path = self._get_laravel_views_path()

        if not views_path:
            return ''

        cfile = super(Action, self).__get_target_string()
        return '{}.blade.php'.format(
            os.path.join(views_path, *cfile.split('.'))
        )

    def executable(self) -> bool:
        return (
            super(Action, self).executable() and
            self._vim.current.buffer.options['filetype'] in ('php', 'blade')
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
