
from typing import List, Tuple

from neovim.api.nvim import Nvim

from curstr.exception import InvalidSettingException


class Setting(object):

    def __init__(self, vim: Nvim) -> None:
        self._vim = vim
        self._actions = {'_': ['file']}

    def get_action_names(self) -> List[Tuple[str, str]]:
        action_names = []  # type: List[Tuple[str, str]]
        action_names.extend([
            self._parse_action_path(path) for path
            in self._actions.get(
                self._vim.current.buffer.options['filetype'], []
            )
        ])
        action_names.extend(self._get_default_action())
        action_names = sorted(set(action_names), key=action_names.index)

        return action_names

    def set_action(self, filetype: str, actions: List[str]):
        self._actions[filetype] = actions

    def _get_default_action(self) -> List[Tuple[str, str]]:
        return [
            self._parse_action_path(action_path)
            for action_path in self._actions['_']
        ]

    def _parse_action_path(self, action_path: str) -> Tuple[str, str]:
        if ':' not in action_path:
            return (action_path, 'default')

        factory_and_action_name = action_path.split(':')

        if len(factory_and_action_name) != 2:
            raise InvalidSettingException(
                'Action path must be factory:action, but actual: {}'.format(
                    action_path
                )
            )

        [factory_name, action_name] = factory_and_action_name
        return (factory_name, action_name)
