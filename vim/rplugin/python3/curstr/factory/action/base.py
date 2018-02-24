
from abc import ABCMeta, abstractmethod

from neovim.api.nvim import Nvim

from curstr.action import Action
from curstr.action_group.base import ActionGroup
from curstr.custom import ActionSourceOption


class ActionFactory(metaclass=ABCMeta):

    def __init__(self, vim: Nvim) -> None:
        self._vim = vim

    def create(self, action_name: str, option: ActionSourceOption) -> Action:
        action_group = self._create_action_group(option)
        return Action(action_group, action_name)

    @abstractmethod
    def _create_action_group(self, option: ActionSourceOption) -> ActionGroup:
        pass

    def echo_message(self, message):
        self._vim.command(
            'echomsg "{}"'.format(
                self._vim.call('escape', str(message), '\\"')
            )
        )
