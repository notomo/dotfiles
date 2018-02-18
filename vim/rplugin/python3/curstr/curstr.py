
from typing import Optional

from neovim.api.nvim import Nvim

from .action import Action
from .exception import ActionFactoryNotFoundException
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

    def load_action_factory(self, factory_name: str) -> bool:
        try:
            self._loader.get_action_factories(factory_name)
            return True
        except ActionFactoryNotFoundException:
            return False

    def _get_executable_action(self, options: Options) -> Optional[Action]:
        setting = Setting(self._vim)
        action_names = setting.get_action_names()
        action_option = options.get('action', '')
        if action_option:
            action_names = [
                (factory_name, action_option)
                for factory_name, action_name
                in action_names
            ]

        for factory_name, action_name in action_names:
            for factory in self._loader.get_action_factories(factory_name):
                action = factory.create(action_name, options)
                if action.is_executable():
                    return action

        return None

    def echo_message(self, message):
        self._vim.command(
            'echomsg "{}"'.format(
                self._vim.call('escape', str(message), '\\"')
            )
        )
