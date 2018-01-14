
from itertools import chain

from .base import Base


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'tabwin'
        self.kind = 'tabwin'

    def __create_tab_candidate(self, tab):
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
            'word': name,
            'abbr': '{}: {} {}{}'.format(tab.number, mod, name, count_str),
            'action__bufnr': buf.number,
            'action__tabnr': tab.number,
        }

    def __create_window_candidate(self, window):
        buf = window.buffer

        name = buf.name
        if name == '':
            name = 'No Name'

        mod = '+' if window.buffer.options['modified'] else ' '

        return {
            'word': name,
            'abbr': '    {}: {} {}'.format(window.number, mod, name),
            'action__bufnr': buf.number,
            'action__tabnr': window.tabpage.number,
            'action__winnr': window.number,
        }

    def gather_candidates(self, context):

        def create(tab):
            tab_candidate = self.__create_tab_candidate(tab)
            if tab_candidate is False:
                return False

            tabwin_candidate = [tab_candidate]

            if len(tab.windows) > 1:
                win_candidates = [
                    self.__create_window_candidate(win)
                    for win in tab.windows
                ]
                tabwin_candidate.extend(win_candidates)

            return tabwin_candidate

        return list(chain.from_iterable(filter(
            lambda x: x is not False,
            [create(t) for t in self.vim.tabpages]
        )))
