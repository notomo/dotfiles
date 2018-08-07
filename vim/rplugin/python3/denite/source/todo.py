
import os.path

from .base import Base


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'todo'
        self.kind = 'file'

    def gather_candidates(self, context):

        def create(line, file_path, number):
            word = line.rstrip()
            if word.startswith('#') or word == '':
                return None
            return {
                'word': word,
                'action__path': file_path,
                'action__line': number,
            }

        def new_file(path: str):
            with open(path, 'a') as f:
                lines = [
                    'todo sample\n',
                    '# done sample\n',
                ]
                f.writelines(lines)

        path = os.path.expanduser('~/.denite_todo')
        if not os.path.isfile(path):
            new_file(path)

        todos = []
        todo_file = open(path)
        todos.extend(filter(
            lambda x: x is not None,
            (
                create(line, path, i)
                for i, line
                in enumerate(todo_file, start=1)
            )
        ))
        todo_file.close()

        return todos
