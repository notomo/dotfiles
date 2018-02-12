
from typing import List

from neovim.api.nvim import Nvim


class Setting(object):

    def __init__(self, vim: Nvim) -> None:
        self._vim = vim

    def get_action_names(self) -> List[str]:
        action_names = []  # type: List[str]
        action_names.extend(
            self._vim.vars['curstr_actions'].get(
                self._vim.current.buffer.options['filetype'], []
            )
        )
        action_names.append(self._get_default_action())
        action_names = sorted(set(action_names), key=action_names.index)
        return action_names

    def _get_default_action(self) -> str:
        return 'file'
