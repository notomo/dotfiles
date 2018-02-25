
from typing import Any, Dict, Optional

from neovim.api.nvim import Nvim

from .action import Action
from .custom import (
    ActionSourceCustom, ExecuteCustom, ExecuteOption, FiletypeCustom
)
from .loader import Loader


class Curstr(object):

    def __init__(self, vim: Nvim) -> None:
        self._vim = vim
        self._filetype_custom = FiletypeCustom(vim)
        self._action_source_custom = ActionSourceCustom(vim)
        self._execute_custom = ExecuteCustom(vim)
        self._loader = Loader(self._vim)

        if hasattr(self._vim, 'channel_id'):
            self._vim.vars['curstr#_channel_id'] = self._vim.channel_id

    def execute(self, arg_string: str) -> None:
        execute_option = self._execute_custom.get(arg_string)
        action = self._get_executable_action(execute_option)
        if action is not None:
            action.execute()
        else:
            self.echo_message('Not found!')

    def custom(self, custom_type: str, args: Dict[str, Any]):
        if custom_type == 'filetype_action_source':
            return self._filetype_custom.set(
                args['filetype'], args['action_source_names']
            )
        if custom_type == 'action_source_alias':
            return self._action_source_custom.set_alias(
                args['alias'], args['action_source_names']
            )
        if custom_type == 'action_source_option':
            return self._action_source_custom.set_option(
                args['action_source_name'], args['option_name'], args['value']
            )
        if custom_type == 'execute':
            return self._execute_custom.set(
                args['option_name'], args['value']
            )

    def _get_executable_action(
        self, execute_option: ExecuteOption
    ) -> Optional[Action]:
        action_source_names = self._filetype_custom.get(
            self._vim.current.buffer.options['filetype']
        )
        action_source_options = self._action_source_custom.apply_alias(
            action_source_names
        )

        use_cache = execute_option.get('use_cache')
        for source_option in action_source_options:
            action_source = self._loader.get_action_source(
                source_option.name, use_cache
            )
            action_name = execute_option.get_action_name(source_option)
            action = action_source.create(action_name, source_option)
            if action.is_executable():
                return action
        return None

    def echo_message(self, message):
        self._vim.command(
            'echomsg "{}"'.format(
                self._vim.call('escape', str(message), '\\"')
            )
        )
