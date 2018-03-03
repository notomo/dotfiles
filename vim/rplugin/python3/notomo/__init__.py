import os.path
import random
import urllib.parse

import neovim


@neovim.plugin
class Notomo(object):

    def __init__(self, _vim):
        self._vim = _vim
        self._mkup_job_id = None

    @neovim.function('_url_decode', sync=True)
    def url_decode(self, args):
        target = args[0]
        return urllib.parse.unquote(target)

    @neovim.function('_url_encode', sync=True)
    def url_encode(self, args):
        target = args[0]
        parsed = urllib.parse.urlparse(target)
        parsed = parsed._replace(
            path=urllib.parse.quote(parsed.path, safe='%/')
        )
        parsed = parsed._replace(
            query=urllib.parse.quote(parsed.query, safe='%/=&')
        )
        return urllib.parse.urlunparse(parsed)

    def echo_message(self, message):
        self._vim.command(
            'echomsg "{}"'.format(self._vim.call('escape', message, '\\"'))
        )

    @neovim.function('_open_browser', sync=True)
    def open_browser(self, args):
        url = self.url_encode(args)
        self._vim.command('OpenBrowser {}'.format(url))

    @neovim.function('_run_http_server_and_open', sync=True)
    def run_http_server_and_open(self, args):
        port = self._vim.vars.get(
            'local#var#port',
            random.randint(49152, 65535)
        )

        if 'local#var#document_root' in self._vim.vars:
            document_root = self._vim.call(
                'expand',
                self._vim.vars['local#var#document_root']
            )

            path = ''
        else:
            document_root = self._vim.call('getcwd')
            path = self._vim.call('expand', '%:p')
            path = (
                self._vim.call('expand', '%')
                if os.path.isfile(path) else ''
            )

        if not os.path.isdir(document_root):
            self.echo_message('{} is not directory.'.format(document_root))
            return

        cd_command = 'cd {};'.format(document_root)
        server_command = 'mkup -http :{}'.format(port)

        if self._mkup_job_id is not None:
            self._vim.call('jobstop', self._mkup_job_id)
            self._mkup_job_id = None

        self._vim.command('tabedit')
        self._vim.command('terminal')
        self._mkup_job_id = self._vim.current.buffer.vars['terminal_job_id']
        self._vim.call(
            'jobsend',
            self._mkup_job_id,
            '{}\n{}\n'.format(cd_command, server_command)
        )

        host = self._vim.vars.get('local#var#host', 'localhost')
        open_url = 'http://{}:{}/{}'.format(host, port, path)
        self.open_browser([open_url])
        self._vim.command('tabprevious')
