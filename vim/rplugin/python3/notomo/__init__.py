import urllib.parse

import neovim


@neovim.plugin
class Notomo(object):

    def __init__(self, _vim):
        self._vim = _vim

    @neovim.function('_url_decode', sync=True)
    def url_decode(self, args):
        target = args[0]
        return urllib.parse.unquote(target)

    @neovim.function('_url_encode', sync=True)
    def url_encode(self, args):
        target = args[0]
        parsed = urllib.parse.urlparse(target)
        parsed = parsed._replace(
            path=urllib.parse.quote(parsed.path, safe='/')
        )
        parsed = parsed._replace(
            query=urllib.parse.quote(parsed.query, safe='%/=')
        )
        return urllib.parse.urlunparse(parsed)

    def echo_message(self, message):
        self._vim.command(
            'echomsg "{}"'.format(self._vim.call('escape', message, '\\"'))
        )
