
import importlib
import sys
from modulefinder import Module
from typing import Dict  # noqa

from neovim.api.nvim import Nvim

from curstr.action.source import ActionSource
from curstr.echoable import Echoable
from curstr.exception import ActionSourceNotFoundException


class Loader(Echoable):

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
        module_name = 'curstr.action.source.{}'.format(
            '.'.join(source_name.split('/'))
        )
        module = self._import(module_name)
        if hasattr(module, 'ActionSource'):
            action_source = module.ActionSource(self._vim)
            self._action_sources[source_name] = action_source
            return action_source

        raise ActionSourceNotFoundException(source_name)

    def _import(self, module_name: str) -> Module:
        if module_name in sys.modules.keys():
            return importlib.reload(sys.modules[module_name])
        return importlib.import_module(module_name)
