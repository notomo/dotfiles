
from .base import Base


class Filter(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'sorter_word'
        self.description = 'sort candidates by word'

    def filter(self, context):
        return sorted(
            context['candidates'],
            key=lambda candidate: candidate['word']
        )
