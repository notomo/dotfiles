
from abc import ABCMeta, abstractmethod

import neovim.api.nvim as nvim  # noqa

from curstr.options import Options


class Action(metaclass=ABCMeta):

    def __init__(self, vim: nvim.Nvim, options: Options) -> None:
        self._options = options
        self._vim = vim
        self._target = None

    def _get_target(self):
        if self._target is not None:
            return self._target
        self._target = self._find_target()
        return self._target

    def _filetype_in(self, *filetypes) -> bool:
        return self._vim.current.buffer.options['filetype'] in filetypes

    @abstractmethod
    def _find_target(self):
        pass

    @abstractmethod
    def execute(self, target):
        pass

    @abstractmethod
    def executable(self) -> bool:
        pass

    def echo_message(self, message):
        self._vim.command(
            'echomsg "{}"'.format(
                self._vim.call('escape', str(message), '\\"')
            )
        )
