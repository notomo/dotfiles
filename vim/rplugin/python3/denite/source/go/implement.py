
import json
import subprocess

from denite.source.base import Base


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'go/implement'
        self.kind = 'file'

    def gather_candidates(self, context):

        def create(line):
            factors = line['pos'].split(':')
            file_path = ''.join(factors[:-2])
            line_number = factors[-2]
            col_number = factors[-1]
            return {
                'word': line['name'],
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

        command = [
            'guru',
            '-json',
            'implements',
            '{}:#{}'.format(path, offset)
        ]

        process = subprocess.Popen(command, stdout=subprocess.PIPE)
        output = process.communicate()[0].decode('ascii')
        result_json = json.loads(output, encoding='utf-8')
        if 'fromptr' not in result_json:
            return []

        return [create(line) for line in result_json['fromptr']]

    def _get_offset(self):
        line_number = self.vim.call('line', '.')
        col_number = self.vim.call('col', '.')
        return self.vim.call('line2byte', line_number) + col_number - 1
