
import os

from .base import Base


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'proto_dir'
        self.kind = 'directory'

    def gather_candidates(self, context):

        def new_file(path: str):
            open(path, 'a').close()

        proto_dir_path = '~/workspace/proto'
        path = os.path.expanduser(proto_dir_path)

        def create(directory: str):
            return {
                'word': directory,
                'action__path': os.path.join(path, directory),
            }

        if not os.path.isdir(path):
            os.makedirs(path)
            os.makedirs(os.path.join(path, 'python'))

        directories = (
            create(d) for d in os.listdir(path)
            if os.path.isdir(os.path.join(path, d))
        )

        if len(context['args']) == 0:
            return list(directories)

        filetype = self.vim.current.buffer.options['filetype']
        filetype_path = os.path.join(path, filetype)
        if not os.path.isdir(filetype_path):
            os.makedirs(filetype_path)
            new_file(os.path.join(filetype_path, 'proto.{}'.format(filetype)))
            return [create(filetype_path)]

        return [
            d for d in directories
            if d['word'] == filetype
        ]
