
import subprocess

from .base import Base


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'proc'
        self.kind = 'proc'

    def gather_candidates(self, context):

        def create(line):
            factors = line.split()
            return {
                'word': line,
                'action__user': factors[0],
                'action__pid': factors[1],
            }

        cmd = 'ps axo user,pid,command'

        process = subprocess.Popen(
            cmd.split(' '),
            stdout=subprocess.PIPE,
        )
        raw_values = process.communicate()[0]

        return [
            create(line)
            for line
            # remove ps command header
            in raw_values.decode('utf-8').strip().split('\n')[1:]
        ]
