
from .base import Base


class Filter(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'sorter_line_number'
        self.description = 'sort candidates by line number'

    def filter(self, context):
        return sorted(
            context['candidates'],
            key=lambda candidate: candidate['action__line']
        )
