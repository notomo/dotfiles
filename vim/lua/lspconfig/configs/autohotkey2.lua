return {
  default_config = {
    -- git clone --depth=1 -b server https://github.com/thqby/vscode-autohotkey2-lsp
    cmd = {
      "node",
      vim.fs.dirname(vim.fn.exepath("AutoHotkey64.exe")) .. "\\vscode-autohotkey2-lsp\\server\\dist\\server.js",
      "--stdio",
    },
    cmd_env = {
      AHK2_LS_CONFIG = vim.json.encode({
        locale = "en-us",
        InterpreterPath = vim.fn.exepath("AutoHotkey64.exe"),
        AutoLibInclude = 0,
      }),
    },
    filetypes = { "autohotkey" },
    root_dir = function(fname)
      return vim.fs.root(fname, ".git") or vim.uv.cwd()
    end,
  },
}
