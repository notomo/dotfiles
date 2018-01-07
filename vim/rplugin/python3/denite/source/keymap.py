
from .base import Base


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'keymap'
        self.kind = 'keymap'

    def gather_candidates(self, context):

        def create(keymap):
            mode = keymap['mode']
            # :help maparg()
            if mode == ' ':
                mode = 'nov'
            elif mode == '!':
                mode = 'ic'

            lhs = keymap['lhs'].replace(' ', '<Space>')

            words = [
                mode,
                'noremap' if keymap['noremap'] == 1 else 'map',
                '<silent>' if keymap['silent'] == 1 else False,
                '<nowait>' if keymap['nowait'] == 1 else False,
                '<buffer>' if keymap['buffer'] != 0 else False,
                '<expr>' if keymap['expr'] == 1 else False,
                lhs,
                keymap['rhs'] if keymap['rhs'] != '' else '<Nop>',
            ]
            return {
                'word': ' '.join([w for w in words if w is not False]),
                'action__lhs': lhs,
                'action__mode': mode,
            }

        modes = (
            context['args'][0]
            if len(context['args']) > 0
            else 'nvoicsxl'
        )
        keymaps = []
        extend = keymaps.extend
        get_keymap = self.vim.api.get_keymap
        buf_get_keymap = self.vim.current.buffer.api.get_keymap
        for m in modes:
            extend(get_keymap(m))
            extend(buf_get_keymap(m))

        return [
            create(m) for m
            # to unique dicts
            in map(dict, set(tuple(m.items()) for m in keymaps))
        ]
