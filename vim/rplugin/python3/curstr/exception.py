
class LogicException(Exception):
    pass


class InvalidSettingException(Exception):
    pass


class ActionFactoryNotFoundException(Exception):

    def __init__(self, action_factory_name: str) -> None:
        self._action_factory_name = action_factory_name

    def __str__(self):
        return 'ActionFactory "{}" is not found.'.format(
            self._action_factory_name
        )
