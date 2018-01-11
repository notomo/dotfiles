
from .buffer import Kind as Buffer


class Kind(Buffer):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'tab'
        self.default_action = 'tabswitch'
        self.redraw_actions += ['delete']
        self.persist_actions += ['delete']

    def action_open(self, context):
        target = context['targets'][0]
        if target['action__tabnr'] != self.vim.current.tabpage.number:
            return self.action_tabswitch(context)

    def action_delete(self, context):
        tab_nums = [target['action__tabnr'] for target in context['targets']]
        count_max = len(self.vim.tabpages)
        if context['split'] == 'tab':
            count_max -= 1
        if len(tab_nums) == count_max:
            return
        for num in sorted(tab_nums, reverse=True):
            self.vim.command('tabclose {}'.format(num))
