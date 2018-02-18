
import os.path
from typing import List  # noqa

from curstr.action_group.base import ActionGroup
from curstr.action_group.help import Help
from curstr.action_group.nothing import Nothing
from curstr.factory.action.base import ActionFactory as Base
from curstr.options import Options


class ActionFactory(Base):

    def _create_action_group(self, options: Options) -> ActionGroup:
        word = self._vim.call('expand', '<cword>')

        contained = []  # type: List[str]
        extend = contained.extend
        for path in self._vim.options['runtimepath'].split(','):
            file_path = os.path.join(path, 'doc/tags')
            if not os.path.isfile(file_path):
                continue

            with open(file_path, 'r') as lines:
                words = [x.split('\t')[0] for x in lines]
                matched = [x for x in words if x == word]
                if matched:
                    return Help(self._vim, matched.pop())

                extend([x for x in words if word in x])

        if not contained:
            return Nothing(self._vim)

        return Help(self._vim, contained.pop())
