
import os
import subprocess

from denite.source.base import Base


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'go/package'
        self.kind = 'go/package'

    def gather_candidates(self, context):

        def create(line, file_path, number):
            word = line.rstrip()
            return {
                'word': word,
                'action__path': file_path,
                'action__line': number
            }

        home = os.path.expanduser('~')
        list_path = '~/.denite_go_package'.replace('~', home)

        if not os.path.isfile(list_path):
            self._create_list_file(list_path)

        f = open(list_path, 'r')
        lines = [
            create(line, list_path, i)
            for i, line
            in enumerate(f, start=1)
        ]
        f.close()

        return lines

    def _create_list_file(self, path):
        process = subprocess.Popen(
            ['go', 'list', '...'],
            stdout=subprocess.PIPE,
        )
        text = process.communicate()[0].decode('ascii')

        f = open(path, 'w')
        f.write(text)
        f.close()
