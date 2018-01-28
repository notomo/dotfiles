
import os.path
import re
import subprocess

from .base import Base


class Source(Base):

    RC_FILES = [
        '~/.bashrc',
    ]

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'alias'
        self.kind = 'alias'

    def gather_candidates(self, context):

        def create(alias):
            match = re.match('^\S+\=\'(.*)\'$', alias)
            return {
                'word': alias,
                'action__terminal_command': match.group(1),
            }

        home = os.path.expanduser('~')
        source_cmds = [
            'source {};'.format(p.replace(home, '~'))
            for p in self.RC_FILES
        ]
        cmd = ' '.join(source_cmds) + 'alias'

        process = subprocess.Popen(
            [cmd],
            stdout=subprocess.PIPE,
            shell=True,
        )
        raw_values = process.communicate()[0]

        return [
            create(alias)
            for alias
            in raw_values.decode('ascii').split('\n')
            if len(alias) != 0
        ]
