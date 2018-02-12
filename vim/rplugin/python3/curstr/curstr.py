
from typing import Optional

from neovim.api.nvim import Nvim

from .action.base import Action
from .loader import Loader
from .options import Options
from .setting import Setting


class Curstr(object):

    def __init__(self, vim: Nvim) -> None:
        self._vim = vim
        self._loader = Loader(self._vim)

        if hasattr(self._vim, 'channel_id'):
            self._vim.vars['curstr#_channel_id'] = self._vim.channel_id

    def execute(self, arg_string: str) -> None:
        options = Options(arg_string)
        action = self._get_executable_action(options)
        if action is not None:
            action.execute()
        else:
            self.echo_message('Not found!')

    def _get_executable_action(self, options: Options) -> Optional[Action]:
        action_option = options.get('action', '')
        if action_option:
            action_names = [action_option]
        else:
            setting = Setting(self._vim)
            action_names = setting.get_action_names()

        for action_name in action_names:
            action_class = self._loader.get_action_class(action_name)
            action = action_class(self._vim, options)
            if action.executable():
                return action

        return None

    def echo_message(self, message):
        self._vim.command(
            'echomsg "{}"'.format(
                self._vim.call('escape', str(message), '\\"')
            )
        )
