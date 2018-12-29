
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
        basename = os.path.basename

        def create(line):
            file_name = basename(line['filename'])
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

        path = context['args'][0]
        command = [
            'motion',
            '-mode', 'decls',
            '-include', 'func,type',
            '-dir', path
        ]

        process = subprocess.Popen(command, stdout=subprocess.PIPE)
        output = process.communicate()[0].decode('ascii')
        result_json = json.loads(output, encoding='utf-8')

        exports = filter(
            lambda x: x['ident'][0].isupper(
            ) and x['filename'].find('_test.go') == -1,
            result_json['decls']
        )

        return [create(line) for line in exports]
