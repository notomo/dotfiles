
import os.path

from .base import Base


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'todo'
        self.kind = 'file'

    def gather_candidates(self, context):

        def create(line, file_path, number):
            return {
                'word': line.rstrip(),
                'action__path': file_path,
                'action__line': number,
            }

        home = os.path.expanduser('~')
        todos = []
        file_paths = [
            '~/.denite_todo',
        ]
        paths = [
            path for path
            in [
                p.replace('~', home) for p
                in file_paths
            ]
            if os.path.isfile(path)
        ]
        for path in paths:
            todo_file = open(path)
            todos.extend([
                create(line, path, i)
                for i, line
                in enumerate(todo_file, start=1)
            ])

        return todos
