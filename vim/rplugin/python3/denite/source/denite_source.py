
from .completion import Source as Completion


class Source(Completion):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'denite_source'
        self.kind = 'denite_source'

    def gather_candidates(self, context):
        context['input'] = 'Denite '
        candidates = super().gather_candidates(context)
        context['is_interactive'] = False

        return candidates
