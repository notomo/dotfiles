
try:
    from curstr.action.group import Help
    from denite.base.kind import Kind as Base

    class Kind(Base):

        def __init__(self, vim):
            super().__init__(vim)

            self.name = 'curstr/altr/help'
            self.default_action = 'tabopen'

        def action_open(self, context):
            self._curstr(context, 'open')

        def action_tabopen(self, context):
            self._curstr(context, 'tab_open')

        def action_vsplit(self, context):
            self._curstr(context, 'vertical_open')

        def _curstr(self, context, action_name):
            targets = context['targets']
            for target in targets:
                word = target['word']
                curstr_group = Help(self.vim, word)
                getattr(curstr_group, action_name)()
except ImportError:
    from denite.kind.command import Kind as Command

    class Kind(Command):
        pass
