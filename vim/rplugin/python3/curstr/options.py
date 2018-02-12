
from typing import Dict


class Options(object):

    _DEFAULT_OPTIONS = {
        'opener': 'edit',
        'action': ''
    }

    def __init__(self, arg_string: str) -> None:
        self._dict = {
            **self._DEFAULT_OPTIONS,
            **self._parse_arg_string(arg_string)
        }

    def _parse_arg_string(self, arg_string: str) -> Dict[str, str]:
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

    def get(self, key: str, default=None):
        return self._dict.get(key, default)
