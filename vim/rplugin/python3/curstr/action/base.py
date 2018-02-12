
from abc import ABCMeta, abstractmethod

import neovim.api.nvim as nvim  # noqa

from curstr.options import Options


class Action(metaclass=ABCMeta):

    def __init__(self, vim: nvim.Nvim, options: Options) -> None:
        self._options = options
        self._vim = vim
        self._target_string = None

    def _get_target_string(self) -> str:
        if isinstance(self._target_string, str):
            return self._target_string
        self._target_string = self.__get_target_string()
        return self._target_string

    @abstractmethod
    def __get_target_string(self) -> str:
        pass

    @abstractmethod
    def execute(self, target: str):
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
