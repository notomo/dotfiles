
from typing import List, Tuple

from .base import Base

Definition = str
FilePath = str
Name = str
Highlight = Tuple[Definition, FilePath, Name]


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'highlight'
        self.kind = 'highlight'
        self.highlights: List[Highlight] = []

    def gather_candidates(self, context) -> List:
        raw_highlights: List[str] = self.vim.call(
            'notomo#denite#redir', 'verbose highlight'
        ).split('\n')[1:]

        highlight_line: str = ''
        for line in raw_highlights:
            stripped = line.strip()
            is_line = len(stripped) == len(line)
            if not len(highlight_line) == 0 and is_line:
                name, definition = self.parse(highlight_line)
                self.highlights.append((definition, '', name))
                highlight_line = stripped
                continue
            elif is_line:
                highlight_line = stripped
                continue
            elif not is_line and len(highlight_line) == 0:
                continue

            name, definition = self.parse(highlight_line)
            file_path = stripped.split()[-1]
            self.highlights.append((definition, file_path, name))
            highlight_line = ''


        def create(highlight: Highlight):
            return {
                'word': highlight[2],
                'abbr': highlight[0],
                'action__path': highlight[1],
            }

        return [
            create(highlight)
            for highlight
            in self.highlights
        ]

    def parse(self, highlight_line: str) -> Tuple[Name, Definition]:
        splitted = highlight_line.split()
        name = splitted[0]
        splitted[1:2] = []
        splitted[:0] = ['xxx']
        definition = ' '.join(splitted)
        return (name, definition)

    def define_syntax(self):
        option = 'he=s+4 contains=ALL containedin=ALL display'
        for hi in self.highlights:
            cmd = f'syntax match {hi[2]} /\\v^ xxx {hi[2]}/{option}'
            self.vim.command(cmd)
