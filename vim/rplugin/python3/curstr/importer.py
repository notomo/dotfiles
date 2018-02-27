
import glob
import os
import sys
from importlib.util import spec_from_file_location
from os.path import join
from typing import List

from curstr.exception import ActionModuleNotFoundException

from .echoable import Echoable


class Importer(Echoable):

    ACTION_MODULE_PATH = 'curstr.action.'

    def __init__(self, vim) -> None:
        self._vim = vim
        sys.meta_path.insert(0, self)

    def find_spec(self, fullname: str, path: List[str], target=None):
        if fullname.startswith(self.ACTION_MODULE_PATH):
            module_paths = fullname[len(self.ACTION_MODULE_PATH):].split('.')
            if len(module_paths) <= 1:
                return None
            module_type = module_paths.pop(0)
            return self._get_spec(module_type, module_paths)
        return None

    def _get_spec(self, module_type: str, module_paths: List[str]):
        name = '/'.join(module_paths)
        path = self._get_path(name, module_type)
        module_path = '{}.{}'.format(module_type, '.'.join(module_paths))
        if os.path.isdir(path):
            path = '{}/__init__.py'.format(path)
        spec = spec_from_file_location(
            'curstr.action.{}'.format(module_path), path
        )
        return spec

    def _get_path(self, name: str, module_type: str) -> str:
        file_path = 'rplugin/python3/curstr/action/{}/**/{}*'.format(
            module_type, name
        )
        expected_file_name = name.split('/')[-1]
        runtime_paths = self._vim.options['runtimepath'].split(',')
        for runtime in runtime_paths:
            for path in glob.iglob(join(runtime, file_path), recursive=True):
                file_name = os.path.splitext(os.path.basename(path))[0]
                if (file_name in ('__init__', 'base')):
                    continue
                if (file_name != expected_file_name):
                    continue

                return path

        raise ActionModuleNotFoundException(module_type, name)
