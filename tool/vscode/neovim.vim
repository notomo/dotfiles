lua vim.env.DOTFILES = vim.env.DOTFILES or vim.fn.expand("~/dotfiles")
luafile $DOTFILES/tool/vscode/neovim.lua
