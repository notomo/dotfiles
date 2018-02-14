
from .base import ActionGroup


class Nothing(ActionGroup):

    def _get_default_action_name(self) -> str:
        return ''
