
import glob
import os
from importlib.util import module_from_spec, spec_from_file_location
from modulefinder import Module  # noqa
from typing import Dict  # noqa
from typing import Callable, Generator

from neovim.api.nvim import Nvim


class Loader(object):

    def __init__(self, vim: Nvim) -> None:
        self._vim = vim

        self._action_classes = {}  # type: Dict[str, Callable]

    def get_action_class(self, action_name: str) -> Callable:
        if action_name in self._action_classes:
            return self._action_classes[action_name]
        action_class = self._load_action_class(action_name)
        self._action_classes[action_name] = action_class
        return action_class

    def _load_action_class(self, action_name: str) -> Callable:
        for path in self._get_action_paths(action_name):
            spec = spec_from_file_location(
                'curstr.action.{}'.format(action_name), path
            )
            module = module_from_spec(spec)  # type: Module
            spec.loader.exec_module(module)
            if hasattr(module, 'Action'):
                return module.Action

        raise ActionNotFoundException(action_name)

    def _get_action_paths(
        self, action_name: str
    ) -> Generator[str, None, None]:
        file_path = 'rplugin/python3/curstr/action/{}.py'.format(action_name)
        runtime_paths = self._vim.options['runtimepath'].split(',')
        for runtime in runtime_paths:
            for path in glob.iglob(os.path.join(runtime, file_path)):
                name = os.path.splitext(os.path.basename(path))[0]
                if (name in ('__init__', 'base')):
                    continue

                yield path

    def echo_message(self, message):
        self._vim.command(
            'echomsg "{}"'.format(
                self._vim.call('escape', str(message), '\\"')
            )
        )


class ActionNotFoundException(Exception):

    def __init__(self, action_name: str) -> None:
        self._action_name = action_name

    def __str__(self):
        return 'Action "{}" is not found.'.format(self._action_name)
