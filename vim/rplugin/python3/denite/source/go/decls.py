
import json
import os.path
import subprocess

from denite.source.base import Base


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'go/decls'
        self.kind = 'file'
        self.sorters = ['sorter_decls']

    def gather_candidates(self, context):
        relpath = os.path.relpath

        path = context['args'][0]
        if len(context['args']) == 2:
            result = self._execute_project(path)
        else:
            result = self._execute(path)

        def create(line):
            file_name = relpath(line['filename'], path)
            return {
                'word': line['ident'],
                'abbr': '{} {}'.format(file_name, line['full']),
                'action__path': line['filename'],
                'action__line': line['line'],
                'action__col': line['col'],
                'action__is_receiver': (
                    line['full'].replace('func ', '').replace(
                        'type ', '')[0] is '('
                )
            }

        exports = filter(
            lambda x: x['ident'][0].isupper(
            ) and x['filename'].find('_test.go') == -1,
            result
        )

        return [create(line) for line in exports]

    def _execute(self, path):
        command = [
            'motion',
            '-mode', 'decls',
            '-include', 'func,type',
            '-dir', path
        ]

        process = subprocess.Popen(command, stdout=subprocess.PIPE)
        output = process.communicate()[0].decode('ascii')
        try:
            result_json = json.loads(output, encoding='utf-8')
        except json.JSONDecodeError:
            return []

        if 'decls' not in result_json:
            return []

        return result_json['decls']

    def _execute_project(self, top_path):
        join = os.path.join
        home = os.path.expanduser('~')

        src_path = join(os.getenv('GOPATH', join(home, 'go')), 'src/')
        package_path = join(top_path, '...')[len(src_path):]

        process = subprocess.Popen(
            ['go', 'list', '-f', '{{.Dir}}', package_path],
            stdout=subprocess.PIPE,
        )
        paths = process.communicate()[0].decode('ascii').split('\n')

        results = []
        extend = results.extend
        for path in paths:
            result = self._execute(path)
            extend(result)

        return results

    def highlight(self):
        self.vim.command('highlight default link myDeclsKeyword Keyword')
        self.vim.command('highlight default link myDeclsType Type')
        self.vim.command('highlight default link myDeclsFile Comment')

    def define_syntax(self):
        super(Source, self).define_syntax()
        self.vim.command('syntax case match')
        self.vim.command(
            'syntax keyword myDeclsKeyword type interface struct func '
        )
        self.vim.command(
            'syntax keyword myDeclsType chan map bool string error '
            'int int8 int16 int32 int64 rune byte '
            'uint uint8 uint16 uint32 uint64 uintptr '
            'float32 float64 complex64 complex128 '
        )
        self.vim.command('syntax case ignore')
        self.vim.command(
            'syntax match myDeclsFile /^ [^[:space:]]*/ '
        )
