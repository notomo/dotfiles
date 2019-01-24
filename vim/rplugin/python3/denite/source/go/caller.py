
import json
import os
import subprocess

from denite.source.base import Base


class Source(Base):

    ROOT_FILES = ['.git']
    EXCLUDES_KEY = 'denite_go_guru_excludes'
    INCLUDE_KEY = 'denite_go_guru_include'

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'go/caller'
        self.kind = 'file'

    def gather_candidates(self, context):

        def create(line):
            factors = line['pos'].split(':')
            file_path = ''.join(factors[:-2])
            line_number = factors[-2]
            col_number = factors[-1]
            file_name = os.path.basename(file_path)
            return {
                'word': line['caller'],
                'abbr': '{}: {}'.format(file_name, line['caller']),
                'action__path': file_path,
                'action__line': line_number,
                'action__col': col_number,
            }

        if len(context['args']) == 0:
            path = self.vim.call('expand', '%:p')
            offset = self._get_offset()
        elif len(context['args']) == 1:
            path = context['args'][0]
            offset = self._get_offset()
        else:
            path = context['args'][0]
            offset = context['args'][1]

        scope = self._get_scope(path)
        if scope == '':
            self.error_message(context, 'not found scope')
            return []
        self.debug('scope: ' + scope)

        command = [
            'guru',
            '-json',
            '-scope',
            scope,
            'callers',
            '{}:#{}'.format(path, offset)
        ]

        process = subprocess.Popen(command, stdout=subprocess.PIPE)
        output = process.communicate()[0].decode('ascii')
        try:
            result_json = json.loads(output, encoding='utf-8')
        except json.JSONDecodeError:
            self.error_message(context, 'output: ' + output)
            return []

        if not result_json:
            return []

        return [create(line) for line in result_json]

    def _get_offset(self):
        line_number = self.vim.call('line', '.')
        col_number = self.vim.call('col', '.')
        return self.vim.call('line2byte', line_number) + col_number - 1

    def _get_scope(self, path):
        home = os.path.expanduser('~')
        go_path = os.getenv('GOPATH', os.path.join(home, 'go'))
        src_path = os.path.join(go_path, 'src')

        def to_scope(dir_path):
            if dir_path.endswith('/'):
                p = dir_path[:-1]
            else:
                p = dir_path

            if self.INCLUDE_KEY in self.vim.current.buffer.vars:
                include = self.vim.current.buffer.vars[self.INCLUDE_KEY]
            else:
                include = p[len(src_path) + 1:] + '/...'

            if self.EXCLUDES_KEY in self.vim.current.buffer.vars:
                excludes = self.vim.current.buffer.vars[self.EXCLUDES_KEY]
            else:
                excludes = []

            scopes = [include]
            scopes.extend(excludes)

            return ',-'.join(scopes)

        paths = os.path.split(path)[0]
        paths_length = len(paths)
        for i in range(paths_length):
            dir_path = os.path.join(paths[0], paths[1:paths_length - i])
            if dir_path == go_path:
                return to_scope(go_path)
            if not os.path.isdir(dir_path):
                continue

            has_root_file = len(list(filter(
                lambda x: os.path.basename(x) in self.ROOT_FILES,
                os.listdir(dir_path)
            )))
            if has_root_file:
                return to_scope(dir_path)

        return to_scope(go_path)
