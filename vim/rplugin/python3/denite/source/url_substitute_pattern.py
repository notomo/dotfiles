from os.path import expanduser, isfile

from .base import Base


class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)

        self.name = "url_substitute_pattern"
        self.kind = "url_bookmark"

    def gather_candidates(self, context):

        if len(context["args"]) == 0:
            return []

        base_url = context["args"][0]

        def create(line, file_path, number):
            # {tag}\t{pat1}\t{sub1}\t{pat2}\t{sub2}...
            factors = line.rstrip().split("\t")
            tag = factors.pop(0)
            url = base_url
            for pat, sub in zip(*[iter(factors)] * 2):
                url = self.vim.call("substitute", url, "\\v{}".format(pat), sub, "g")

            return {
                "word": "\t".join([tag, url]),
                "action__path": file_path,
                "action__line": number,
                "action__url": url,
            }

        def new_file(path: str):
            with open(path, "a") as f:
                lines = ["relative\t^\ze\/\thttps://github.com"]
                f.writelines(lines)

        path = expanduser("~/.local/.denite_url_substitute_pattern")
        if not isfile(path):
            new_file(path)

        urls = []
        url_file = open(path)
        urls.extend([create(line, path, i) for i, line in enumerate(url_file, start=1)])
        url_file.close()

        urls = [
            x for x in urls if "http" in x["action__url"] and ":" in x["action__url"]
        ]
        return list({v["action__url"]: v for v in reversed(urls)}.values())
