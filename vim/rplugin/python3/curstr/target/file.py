
from neovim.api.nvim import Nvim


class File(object):

    def __init__(self, path='', row=0, column=0) -> None:
        self._path = path
        self._row = row
        self._column = column

    @classmethod
    def current(cls, vim: Nvim, row: int, column: int):
        return cls(vim.call('expand', '%:p'), row, column)

    @property
    def path(self):
        return self._path

    @property
    def row(self):
        return self._row

    @property
    def column(self):
        return self._column

    def has_position(self) -> bool:
        return (
            self._row > 0 and
            self._column > 0
        )

    def is_current(self, vim: Nvim) -> bool:
        path = vim.call('fnamemodify', self._path, ':p')
        return path == vim.call('expand', '%:p')
