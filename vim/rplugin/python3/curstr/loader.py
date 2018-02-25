
import glob
import os
from importlib.util import module_from_spec, spec_from_file_location
from modulefinder import Module  # noqa
from os.path import join
from typing import Dict  # noqa

from neovim.api.nvim import Nvim

from curstr.action.source import ActionSource
from curstr.exception import ActionSourceNotFoundException


class Loader(object):

    def __init__(self, vim: Nvim) -> None:
        self._vim = vim

        self._action_sources = {}  # type: Dict[str, ActionSource]

    def get_action_source(
        self, source_name: str, use_cache: bool
    ) -> ActionSource:
        if use_cache and source_name in self._action_sources:
            return self._action_sources[source_name]
        return self._load_action_source(source_name)

    def _load_action_source(self, source_name: str) -> ActionSource:
        path = self._get_action_source_path(source_name)
        module_name = '.'.join(source_name.split('/'))
        spec = spec_from_file_location(
            'curstr.action.source.{}'.format(module_name), path
        )
        module = module_from_spec(spec)  # type: Module
        spec.loader.exec_module(module)
        if hasattr(module, 'ActionSource'):
            action_source = module.ActionSource(self._vim)
            self._action_sources[source_name] = action_source
            return action_source

        raise ActionSourceNotFoundException(source_name)

    def _get_action_source_path(self, source_name: str) -> str:
        file_path = 'rplugin/python3/curstr/action/source/**/{}.py'.format(
            source_name
        )
        runtime_paths = self._vim.options['runtimepath'].split(',')
        for runtime in runtime_paths:
            for path in glob.iglob(join(runtime, file_path), recursive=True):
                name = os.path.splitext(os.path.basename(path))[0]
                if (name in ('__init__', 'base')):
                    continue

                return path

        raise ActionSourceNotFoundException(source_name)

    def echo_message(self, message):
        self._vim.command(
            'echomsg "{}"'.format(
                self._vim.call('escape', str(message), '\\"')
            )
        )
