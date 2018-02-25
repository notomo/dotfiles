
from neovim.api.nvim import Nvim


class Custom(object):

    def __init__(self, vim: Nvim) -> None:
        self._vim = vim

    def echo_message(self, message):
        self._vim.command(
            'echomsg "{}"'.format(
                self._vim.call('escape', str(message), '\\"')
            )
        )
