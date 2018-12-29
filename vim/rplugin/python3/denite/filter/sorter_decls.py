
from .base import Base


class Filter(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'sorter_decls'

    def filter(self, context):
        return sorted(
            context['candidates'],
            key=lambda x: x['action__is_receiver']
        )
