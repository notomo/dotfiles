from urllib.parse import urlparse
import neovim
import requests
import json
import subprocess

@neovim.plugin
class Jesponsiv2(object):

    UTF8 = 'utf-8'
    JESPONSIV2_FILE_TYPE = 'jesponsiv2'

    def __init__(self, vim):
        self.vim = vim
        self.default_vars = {
            'open_buffer_cmd': 'tabnew',
            'json_indent': 4,
            'buffer_title': 'jesponsiv2',
            'temp_file_path': '/tmp/jesponsiv2.html',
        }

    @neovim.command('Jesponse', nargs=1)
    def jesponse(self, args):
        url = args[0]
        # validate before request
        if self.validate_url(url) is False:
            return self.echo_message('Invalid url: {url}'.format(url=url))
        # request
        try:
            response = requests.get(url)
        except requests.exceptions.RequestException as exception:
            return self.echo_message('RequestException')
        # setup buffer content
        if response.headers['content-type'].find('text/html') != -1:
            try:
                buffer_lines = self.get_html_buffer_lines(response)
            except OSError:
                return self.echo_message('OSError')
        elif response.headers['content-type'].find('application/json') != -1:
            try:
                buffer_lines = self.get_json_buffer_lines(response)
            except json.decoder.JSONDecodeError:
                return self.echo_message('JSONDecodeError')
        else:
            buffer_lines = self.get_text_buffer_lines(response)
        self.add_buffer_header(response, buffer_lines)
        self.vim.command(
            '{cmd} {title}'.format(
                cmd=self.get_var('open_buffer_cmd'),
                title=self.get_var('buffer_title'),
            )
        )
        self.setup_buffer(self.vim.current.buffer, buffer_lines)

    @staticmethod
    def validate_url(url):
        parse_result = urlparse(url)
        return parse_result.scheme != ''

    def add_buffer_header(self, response, lines):
        lines[:0] = [
            '// url: ' + response.url,
            '// status_code: ' + str(response.status_code),
            '// content-type: ' + str(response.headers['content-type']),
            '',
        ]
        return lines

    def get_json_buffer_lines(self, response):
        json_dict = json.loads(response.text, encoding=self.UTF8)
        formatted_json = json.dumps(
            json_dict,
            ensure_ascii=False,
            indent=self.get_var('json_indent'),
            separators=(',', ': ')
        )
        return formatted_json.split('\n')

    def get_html_buffer_lines(self, response):
        temp_file_path = self.get_var('temp_file_path')
        temp_file = open(temp_file_path, 'w')
        temp_file.write(response.text)
        temp_file.close()
        process = subprocess.Popen(['lynx', '-dump', '-nolist', '-nonumbers', temp_file_path], stdout=subprocess.PIPE)
        lines = process.stdout.readlines()
        return [line.decode(self.UTF8).rstrip() for line in lines]

    def get_text_buffer_lines(self, response):
        return [line.rstrip() for line in response.content.split('\n')]

    def setup_buffer(self, target_buffer, lines):
        buffer_options = target_buffer.options
        buffer_options['buftype'] = 'nofile'
        buffer_options['swapfile'] = False
        buffer_options['buflisted'] = False
        buffer_options['filetype'] = self.JESPONSIV2_FILE_TYPE
        self.vim.command('silent doautocmd WinEnter')
        self.vim.command('silent doautocmd BufWinEnter')
        self.vim.command('silent doautocmd FileType {file_type}'.format(file_type=self.JESPONSIV2_FILE_TYPE))
        target_buffer[:] = lines

    def get_var(self, attribute_name):
        var_name = 'jesponsiv2#{attribute}'.format(attribute=attribute_name)
        return self.vim.vars.get(var_name, self.default_vars[attribute_name])

    def echo_message(self, message):
        self.vim.command('echomsg "{}"'.format(message))

