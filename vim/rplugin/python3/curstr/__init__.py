
import neovim

from .curstr import Curstr


@neovim.plugin
class CurstrHandler(object):

    def __init__(self, vim):
        self._curstr = Curstr(vim)

    @neovim.function('_curstr_execute', sync=True)
    def execute(self, args):
        self._curstr.execute(args[0])

    @neovim.function('_curstr_custom', sync=True)
    def custom(self, args):
        self._curstr.custom(args[0], args[1])
