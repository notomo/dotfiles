import urllib.parse

from denite.kind.file import Kind as File


class Kind(File):
    def __init__(self, vim):
        super().__init__(vim)

        self.name = "url_bookmark"
        self.default_action = "browser_open"

    def action_browser_open(self, context):
        for target in context["targets"]:
            url = self._url_encode(target["action__url"])
            self.vim.command("OpenBrowser {}".format(url))

    def action_activate(self, context):
        for target in context["targets"]:
            url = self._url_encode(target["action__url"])
            self.vim.command("Ctrlb tab/tabOpen -url={}".format(url))

    def action_yank(self, context):
        for target in context["targets"]:
            target["word"] = target["word"].split("\t")[-1]
        super().action_yank(context)

    def _url_encode(self, url):
        parsed = urllib.parse.urlparse(url)
        parsed = parsed._replace(path=urllib.parse.quote(parsed.path, safe="%/"))
        parsed = parsed._replace(query=urllib.parse.quote(parsed.query, safe="%/=&"))
        return urllib.parse.urlunparse(parsed)
