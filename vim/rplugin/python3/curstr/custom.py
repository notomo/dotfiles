
from itertools import chain
from typing import Any, Dict, List  # noqa

from curstr.exception import InvalidCustomException


class FiletypeCustom(object):

    def __init__(self) -> None:
        self._action_source_names = {'_': ['file']}

    def set(self, filetype: str, action_source_names: List[str]):
        self._action_source_names[filetype] = action_source_names

    def get(self, filetype: str):
        action_source_names = [
            name for name
            in self._action_source_names.get(filetype, [])
        ]
        action_source_names.extend(self._action_source_names['_'])
        action_source_names = sorted(
            set(action_source_names), key=action_source_names.index
        )

        return action_source_names


class ActionSourceOption(object):

    def __init__(self, name: str, options: Dict) -> None:
        self._name = name
        self._options = options

    @property
    def name(self):
        return self._name

    def get(self, key: str, default=None):
        return self._options.get(key, default)


class ActionSourceCustom(object):

    def __init__(self) -> None:
        self._action_source_aliases = {
            'vim/function': [
                'vim/autoload_function',
                'vim/script_function',
            ],
        }
        self._action_source_options = {}  # type: Dict[str, Dict[str, str]]

    def set_alias(self, alias: str, action_source_names: List[str]):
        self._action_source_aliases[alias] = action_source_names

    def apply_alias(
        self, action_source_names: List[str]
    ) -> List[ActionSourceOption]:
        options = [self.get_option(name) for name in action_source_names]
        return list(chain.from_iterable(
            map(self._apply_alias, options)
        ))

    def _apply_alias(
        self, option: ActionSourceOption
    ) -> List[ActionSourceOption]:
        name = option.name
        aliased = self._action_source_aliases.get(name, name)
        if aliased == name:
            return [option]

        options = [
            ActionSourceOption(
                name, {**self.get_option(name), **option._options}
            )
            for name in aliased
        ]
        try:
            return list(chain.from_iterable(
                map(self._apply_alias, options)
            ))
        except RecursionError:
            raise InvalidCustomException(
                'Invalid alias definition: {}'.format(name)
            )

    def set_option(self, action_source_name: str, option_name: str, value):
        option = self._action_source_options.get(action_source_name, {})
        option[option_name] = value
        self._action_source_options[action_source_name] = option

    def get_option(self, action_source_name: str):
        option = self._action_source_options.get(action_source_name, {})
        return ActionSourceOption(action_source_name, option)


class ExecuteCustom(object):

    def __init__(self) -> None:
        self._options = {
            'use-cache': '1',
            'action': '',
        }

    def set(self, option_name: str, value):
        if option_name in self._options:
            self._options[option_name] = value
        raise InvalidCustomException(
            '{} cannot be customized'.format(option_name)
        )

    def get(self, arg_string: str):
        options = {
            **self._options,
            **self._parse_arg_string(arg_string),
        }
        return ExecuteOption(options)

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


class ExecuteOption(object):

    def __init__(self, options: Dict) -> None:
        self._options = options

    def get(self, key: str, default=None):
        return self._options.get(key, default)

    def get_action_name(self, action_source_option: ActionSourceOption) -> str:
        if self._options['action']:
            return self._options['action']
        if action_source_option.get('action'):
            return action_source_option.get('action')
        return 'default'
