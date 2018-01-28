
from .file import Kind as File


class Kind(File):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'url_bookmark'
        self.default_action = 'browser_open'

    def action_browser_open(self, context):
        for target in context['targets']:
            self.vim.command('OpenBrowser {}'.format(target['action__url']))
