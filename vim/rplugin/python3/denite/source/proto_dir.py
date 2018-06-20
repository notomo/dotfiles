
import os

from .base import Base


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'proto_dir'
        self.kind = 'directory'

    def gather_candidates(self, context):
        proto_dir_path = '~/workspace/proto'
        home = os.path.expanduser('~')
        path = proto_dir_path.replace('~', home)

        if not os.path.isdir(path):
            return []

        directories = (
            {
                'word': d,
                'action__path': os.path.join(path, d),
            } for d in os.listdir(path)
            if os.path.isdir(os.path.join(path, d))
        )

        if len(context['args']) == 0:
            return list(directories)

        filetype = self.vim.current.buffer.options['filetype']
        return [
            d for d in directories
            if d['word'] == filetype
        ]
