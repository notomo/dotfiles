
# import codecs
import subprocess

from .base import Base


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'proc'
        self.kind = 'word'

    def gather_candidates(self, context):

        def create(line):
            return {
                'word': line,
            }

        cmd = 'ps aux'

        process = subprocess.Popen(
            cmd.split(' '),
            stdout=subprocess.PIPE,
        )
        raw_values = process.communicate()[0]

        return [
            create(line)
            for line
            in raw_values.decode('utf-8').split('\n')
        ]
