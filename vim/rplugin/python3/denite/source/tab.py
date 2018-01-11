
from .base import Base


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'tab'
        self.kind = 'tab'

    def gather_candidates(self, context):

        current_tab_num = self.vim.current.tabpage.number
        no_current = True if 'no_current' in context['args'] else False

        def create(tab, number):
            if no_current and tab.number == current_tab_num:
                return False
            elif (
                self.vim.current.buffer.options['filetype'] == 'denite' and
                tab.number == current_tab_num
            ):
                return False

            buf = tab.window.buffer

            name = buf.name
            if name == '':
                name = 'No Name'

            window_num = len(tab.windows)
            count_str = '[{}]'.format(window_num) if window_num > 1 else ''

            mod_count = len(list(filter(
                lambda w: w.buffer.options['modified'],
                tab.windows
            )))
            mod = '+' if mod_count > 0 else ' '

            return {
                'word': '{}{}'.format(mod, name),
                'abbr': '{}: {} {}{}'.format(number, mod, name, count_str),
                'action__bufnr': buf.number,
                'action__tabnr': tab.number,
            }

        return list(filter(
            lambda x: x is not False,
            [create(t, i) for i, t in enumerate(self.vim.tabpages, start=1)]
        ))
