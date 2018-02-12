
from typing import Dict  # noqa

from neovim.api.nvim import Nvim

from .loader import Loader


class Curstr(object):

    def __init__(self, vim: Nvim) -> None:
        self._vim = vim
        self._loader = Loader(self._vim)

        if hasattr(self._vim, 'channel_id'):
            self._vim.vars['curstr#_channel_id'] = self._vim.channel_id

    def execute(self, arg_string: str):
        options = self._get_options(arg_string)
        action = self._get_executable_action(options)
        if action is not None:
            action.execute()
        else:
            self.echo_message('Not found!')

    def _get_executable_action(self, options):
        action_option = options.get('action', '')
        action_names = []
        if action_option:
            action_names.append(action_option)
        else:
            action_names.extend(
                self._vim.vars['curstr_actions'].get(
                    self._vim.current.buffer.options['filetype'], []
                )
            )
            action_names.append(self._get_default_action())
            action_names = sorted(set(action_names), key=action_names.index)

        for action_name in action_names:
            action_class = self._loader.get_action_class(action_name)
            action = action_class(self._vim, options)
            if action.executable():
                return action

    def _get_options(self, arg_string: str):
        return {
            **self._get_default_options(),
            **self._parse_options(arg_string)
        }

    def _get_default_options(self) -> Dict[str, str]:
        return {
            'opener': 'edit',
            'action': ''
        }

    def _get_default_action(self) -> str:
        return 'file'

    def _parse_options(self, arg_string: str) -> Dict[str, str]:
        options = {}
        for arg in arg_string.split(' '):
            key_value = arg.split('=')
            key = key_value[0]
            if not key.startswith('-'):
                continue
            elif len(key_value) > 1:
                options[key[1:]] = key_value[1]
            else:
                options[key[1:]] = '1'

        return options

    def echo_message(self, message):
        self._vim.command(
            'echomsg "{}"'.format(
                self._vim.call('escape', str(message), '\\"')
            )
        )
