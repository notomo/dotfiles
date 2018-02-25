
from abc import ABCMeta, abstractmethod

from neovim.api.nvim import Nvim


class ActionGroup(metaclass=ABCMeta):

    def __init__(self, vim: Nvim) -> None:
        self._vim = vim

    @abstractmethod
    def action_default(self):
        pass
