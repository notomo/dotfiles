
import glob
import os
from importlib.util import module_from_spec, spec_from_file_location
from modulefinder import Module  # noqa
from os.path import join
from typing import Dict  # noqa

from neovim.api.nvim import Nvim

from curstr.exception import ActionFactoryNotFoundException
from curstr.factory.action.base import ActionFactory


class Loader(object):

    def __init__(self, vim: Nvim) -> None:
        self._vim = vim

        self._action_factories = {}  # type: Dict[str, ActionFactory]

    def get_action_factory(self, factory_name: str) -> ActionFactory:
        if factory_name in self._action_factories:
            return self._action_factories[factory_name]
        action_factory = self._load_action_factory(factory_name)
        self._action_factories[factory_name] = action_factory
        return action_factory

    def _load_action_factory(self, factory_name: str) -> ActionFactory:
        path = self._get_action_factory_path(factory_name)
        spec = spec_from_file_location(
            'curstr.factory.action.{}'.format(factory_name), path
        )
        module = module_from_spec(spec)  # type: Module
        spec.loader.exec_module(module)
        if hasattr(module, 'ActionFactory'):
            return module.ActionFactory(self._vim)

        raise ActionFactoryNotFoundException(factory_name)

    def _get_action_factory_path(self, factory_name: str) -> str:
        file_path = 'rplugin/python3/curstr/factory/action/**/{}.py'.format(
            factory_name
        )
        runtime_paths = self._vim.options['runtimepath'].split(',')
        for runtime in runtime_paths:
            for path in glob.iglob(join(runtime, file_path), recursive=True):
                name = os.path.splitext(os.path.basename(path))[0]
                if (name in ('__init__', 'base')):
                    continue

                return path

        raise ActionFactoryNotFoundException(factory_name)

    def echo_message(self, message):
        self._vim.command(
            'echomsg "{}"'.format(
                self._vim.call('escape', str(message), '\\"')
            )
        )
