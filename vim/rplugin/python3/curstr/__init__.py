
import neovim

from .curstr import Curstr


@neovim.plugin
class CurstrHandler(object):

    def __init__(self, vim):
        self._vim = vim

    @neovim.function('_execute_curstr', sync=True)
    def execute(self, args):
        Curstr(self._vim).execute(args[0])
