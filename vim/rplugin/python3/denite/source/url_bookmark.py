
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
                'word': '\t'.join(factors),
                'action__path': file_path,
                'action__line': number,
                'action__url': url,
            }

        def new_file(path: str):
            with open(path, 'a') as f:
                lines = [
                    'sample\thttps://github.com/notomo/dotfiles',
                ]
                f.writelines(lines)

        def gather(path: str):
            urls = []
            url_file = open(path, 'r')
            urls.extend([
                create(line, path, i)
                for i, line
                in enumerate(url_file, start=1)
            ])
            url_file.close()
            return urls

        home = os.path.expanduser('~')
        path = '~/.denite_url_bookmark'.replace('~', home)
        if not os.path.isfile(path):
            new_file(path)

        urls = gather(path)

        if not urls:
            new_file(path)
            urls = gather(path)

        return urls
