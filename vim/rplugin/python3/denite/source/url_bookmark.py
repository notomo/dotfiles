
import os.path

from .base import Base


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'url_bookmark'
        self.kind = 'url_bookmark'

        self.sorters = ['sorter_length', 'sorter_word']

    def gather_candidates(self, context):

        def create(line, file_path, number):
            factors = [factor.rstrip() for factor in line.split("\t")]
            url = factors[-1]

            return {
                'word': ' '.join(factors),
                'action__path': file_path,
                'action__line': number,
                'action__url': url,
            }

        home = os.path.expanduser('~')
        urls = []
        file_paths = [
            '~/.denite_url_bookmark',
        ]
        for path in file_paths:
            url_file = open(path.replace('~', home))
            urls.extend([
                create(line, path, i)
                for i, line
                in enumerate(url_file, start=1)
            ])

        return urls
