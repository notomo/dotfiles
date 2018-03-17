
from curstr.action.group import Help
from denite.kind.base import Kind as Base


class Kind(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'curstr/altr/help'
        self.default_action = 'tabopen'

    def action_open(self, context):
        self._curstr(context, 'action_open')

    def action_tabopen(self, context):
        self._curstr(context, 'action_tab_open')

    def action_vsplit(self, context):
        self._curstr(context, 'action_vertical_open')

    def _curstr(self, context, action_name):
        targets = context['targets']
        for target in targets:
            word = target['word']
            curstr_group = Help(self.vim, word)
            getattr(curstr_group, action_name)()
