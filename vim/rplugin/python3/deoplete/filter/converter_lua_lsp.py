from deoplete.base.filter import Base
from deoplete.util import Candidates, Nvim, UserContext


class Filter(Base):
    def __init__(self, vim: Nvim) -> None:
        super().__init__(vim)

        self.name = "converter_lua_lsp"
        self.description = "remove info lua lsp"

    def filter(self, context: UserContext) -> Candidates:
        if self.vim.current.buffer.options["filetype"] != "lua":
            return context["candidates"]

        for candidate in context["candidates"]:
            candidate["word"] = candidate["word"].split(" ")[0]
        return context["candidates"]
