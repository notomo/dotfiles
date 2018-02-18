
from itertools import chain
from typing import List

from neovim.api.nvim import Nvim

from curstr.exception import InvalidSettingException


class Alias(object):

    def __init__(self, vim: Nvim) -> None:
        self._vim = vim
        self._aliases = {
            'vim/function': [
                'vim/autoload_function',
                'vim/script_function',
            ],
        }

    def apply_alias(self, factory_name: str) -> List[str]:
        aliased = self._aliases.get(factory_name, factory_name)
        if aliased == factory_name:
            return [factory_name]

        try:
            return list(chain.from_iterable(
                map(self.apply_alias, aliased)
            ))
        except RecursionError:
            raise InvalidSettingException(
                'Invalid alias definition: {}'.format(factory_name)
            )

    def set(self, alias_name: str, names: List[str]):
        self._aliases[alias_name] = names
