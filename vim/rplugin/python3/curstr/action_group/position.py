

from neovim.api.nvim import Nvim

from .base import ActionGroup


class Position(ActionGroup):

    def __init__(self, vim: Nvim, row: int, column: int) -> None:
        super().__init__(vim)
        self._row = row
        self._column = column

    @property
    def row(self):
        return self._row

    @property
    def column(self):
        return self._column

    def action_open(self):
        self._open('')

    def action_tab_open(self):
        pos = self._vim.call('getpos', '.')
        self._open('tabedit %')

        # NOTICE: save position before opening tab
        self._vim.command('mark \'')
        self._vim.call('cursor', pos[1], pos[2])

        self._open('')

    def action_vertical_open(self):
        self._open('vsplit')

    def action_horizontal_open(self):
        self._open('split')

    def _open(self, command: str):
        if command != '':
            self._vim.command(command)
        # FIXME: save column
        self._vim.command('mark \'')
        self.goto()

    def goto(self):
        self._vim.call('cursor', self._row, self._column)

    def _get_default_action_name(self) -> str:
        return 'open'
