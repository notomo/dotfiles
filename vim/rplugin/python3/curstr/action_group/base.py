
from abc import ABCMeta, abstractmethod

from neovim.api.nvim import Nvim


class ActionGroup(metaclass=ABCMeta):

    def __init__(self, vim: Nvim) -> None:
        self._vim = vim

    def action_default(self):
        getattr(
            self,
            'action_{}'.format(self._get_default_action_name())
        )()

    @abstractmethod
    def _get_default_action_name(self) -> str:
        pass
