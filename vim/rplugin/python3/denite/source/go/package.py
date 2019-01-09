
import os
import subprocess

from denite.source.base import Base


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'go/package'
        self.kind = 'go/package'
        self.sorters = ['sorter_length']

    def gather_candidates(self, context):

        def create(line, file_path, number):
            [import_path, directory] = line.rstrip().split(' ')
            return {
                'word': import_path,
                'action__path': directory,
                'action__line': number
            }

        list_path = os.path.expanduser('~/.local/.denite_go_package')

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
            ['go', 'list', '-f', '{{.ImportPath}} {{.Dir}}', '...'],
            stdout=subprocess.PIPE,
        )
        text = process.communicate()[0].decode('ascii')

        # HACK: append builtin
        any_standard_package = 'archive/tar '
        start = text.find(any_standard_package) + len(any_standard_package)
        end = text.find('\n', start) - len(any_standard_package)
        builtin_path = text[start:end] + '/builtin'

        f = open(path, 'a')
        f.write(text)
        f.writelines(['builtin ' + builtin_path])
        f.close()
