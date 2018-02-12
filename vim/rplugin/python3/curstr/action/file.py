
import os.path

from curstr.target.file import File as Target

from .base import Action as Base


class Action(Base):

    _OPEN_COMMANDS = {
        'vertical': 'vsplit',
        'horizontal': 'split',
        'tab': 'tabedit',
        'edit': 'edit',
    }

    def _find_target(self) -> Target:
        path = self._vim.call('expand', '<cfile>')
        return Target(path)

    def execute(self):
        target = self._get_target()
        is_current = target.is_current(self._vim)
        has_position = target.has_position()
        if not is_current:
            self._vim.command('{} {}'.format(
                self._get_open_command(self._options.get('opener')),
                target.path
            ))
        if is_current and has_position:
            # FIXME: save column
            self._vim.command('mark \'')
        if has_position:
            self._vim.call('cursor', target.row, target.column)

    def executable(self) -> bool:
        path = self._vim.call('fnamemodify', self._get_target().path, ':p')
        return os.path.isfile(path)

    def _get_open_command(self, opener: str) -> str:
        return self._OPEN_COMMANDS[opener]
