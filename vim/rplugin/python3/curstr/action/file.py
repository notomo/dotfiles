
import os.path

from .base import Action as Base


class Action(Base):

    _OPEN_COMMANDS = {
        'vertical': 'vsplit',
        'horizontal': 'split',
        'tab': 'tabedit',
        'edit': 'edit',
    }

    def __get_target_string(self) -> str:
        return self._vim.call('expand', '<cfile>')

    def execute(self):
        self._vim.command('{} {}'.format(
            self._get_open_command(self._options.get('opener')),
            self._get_target_string()
        ))

    def executable(self) -> bool:
        path = self._vim.call('fnamemodify', self._get_target_string(), ':p')
        return os.path.isfile(path)

    def _get_open_command(self, opener: str) -> str:
        return self._OPEN_COMMANDS[opener]
