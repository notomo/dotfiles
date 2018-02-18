
import neovim

from .curstr import Curstr


@neovim.plugin
class CurstrHandler(object):

    def __init__(self, vim):
        self._curstr = Curstr(vim)

    @neovim.function('_execute_curstr', sync=True)
    def execute(self, args):
        self._curstr.execute(args[0])

    @neovim.function('_load_curstr', sync=True)
    def load(self, args):
        return self._curstr.load_action_factory(args[0])
