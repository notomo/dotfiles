import neovim
import requests
import json
from urllib.parse import urlparse

@neovim.plugin
class Jesponsiv2(object):

    def __init__(self, vim):
        self.vim = vim

    @neovim.command('Jesponsiv2', nargs=1)
    def test(self, args):
        url = args[0]
        parse_result = urlparse(url)
        if parse_result.scheme == '':
            self.vim.command('echomsg "Invalid url: {}"'.format(url))
            return
        result = requests.get(url)
        if result.status_code != requests.codes.ok:
            self.vim.command('echomsg "{}"'.format(result.status_code))
            return

        self.vim.command('tabnew response')
        current_buffer = self.vim.current.buffer
        buffer_options = current_buffer.options
        buffer_options['buftype'] = 'nofile'
        buffer_options['swapfile'] = False
        buffer_options['buflisted'] = False
        buffer_options['filetype'] = 'javascript'

        self.vim.command('silent doautocmd WinEnter')
        self.vim.command('silent doautocmd BufWinEnter')
        self.vim.command('silent doautocmd FileType javascript')

        buffer_lines = ['// ' + url, '']
        json_dict = json.loads(result.text, encoding='utf-8')
        formatted_json = json.dumps(json_dict, ensure_ascii=False, indent=4, separators=(',', ': '))
        buffer_lines.extend(formatted_json.split('\n'))
        current_buffer[:] = buffer_lines

