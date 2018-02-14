
from neovim.api.nvim import Nvim

from .file import File
from .position import Position


class FilePosition(File):

    def __init__(self, vim: Nvim, path: str, row: int, column: int) -> None:
        super().__init__(vim, path)
        self._position = Position(vim, row, column)

    def action_open(self):
        super().action_open()
        self._position.goto()

    def action_tab_open(self):
        super().action_tab_open()
        self._position.goto()

    def action_vertical_open(self):
        super().action_vertical_open()
        self._position.goto()

    def action_horizontal_open(self):
        super().action_horizontal_open()
        self._position.goto()
