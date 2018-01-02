
from .buffer import Kind as Buffer


class Kind(Buffer):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'tab'
        self.default_action = 'tabswitch'

    def action_open(self, context):
        return self.__tabswitch(context)

    def action_tabopen(self, context):
        return self.__tabswitch(context)

    def __tabswitch(self, context):
        current_num = self.vim.current.tabpage.number
        targets = list(filter(
            lambda x: x['action__tabnr'] != current_num,
            context['targets']
        ))
        if len(targets) != len(context['targets']):
            return
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
