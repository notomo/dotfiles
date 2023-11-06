vim.keymap.set(
  "n",
  "gw",
  [=[<Cmd>lua require("reacher").start({input = "\\v[^[:alnum:]]\\zs[[:alnum:]]+&.\\zs"})<CR>]=]
)
vim.keymap.set(
  "n",
  "gW",
  [=[<Cmd>lua require("reacher").start_multiple({input = "\\v[^[:alnum:]]\\zs[[:alnum:]]+&.\\zs"})<CR>]=]
)
vim.keymap.set({ "n", "x" }, "gs", [[<Cmd>lua require("reacher").start()<CR>]])
vim.keymap.set({ "n", "x" }, "gS", [[<Cmd>lua require("reacher").start_multiple()<CR>]])

local safe_start = function(args)
  local ok, result = pcall(require("reacher").start, args)
  if ok then
    return
  end
  if not result:find([=[^%[reacher%]]=]) then
    error(result)
  end
  vim.notify(result, vim.log.levels.WARN)
end
vim.keymap.set("n", "gj", function()
  safe_start({ first_row = vim.fn.line(".") + 1 })
end)
vim.keymap.set("n", "gk", function()
  safe_start({ last_row = vim.fn.line(".") - 1 })
end)

vim.keymap.set({ "n", "x" }, "gl", function()
  require("reacher").start({
    first_row = vim.fn.line("."),
    last_row = vim.fn.line("."),
  })
end)
vim.keymap.set("n", "g<CR>", [[<Cmd>lua require("reacher").again({input = vim.fn.histget("/")})<CR><ESC>]])

vim.api.nvim_create_augroup("reacher_setting", {})
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "reacher_setting",
  pattern = { "reacher" },
  callback = function()
    vim.keymap.set("i", "jj", [[<Cmd>lua require("reacher").cancel()<CR>]], { silent = true, buffer = true })
    vim.keymap.set("i", "<Space>", [[<Cmd>lua require("reacher").finish()<CR>]], { buffer = true })
    vim.keymap.set("i", "<C-Space>", [[<Cmd>lua require("reacher").finish()<CR>]], { buffer = true })
    vim.keymap.set("i", "<C-s>", [[<Space>]], { buffer = true })
    vim.keymap.set("i", "<CR>", [[<ESC>]], { buffer = true })
    vim.keymap.set("i", "<Tab>", [[<Cmd>lua require("reacher").next()<CR>]], { buffer = true })
    vim.keymap.set("i", "<S-Tab>", [[<Cmd>lua require("reacher").previous()<CR>]], { buffer = true })
    vim.keymap.set("i", "<C-j>", [[<Cmd>lua require("reacher").forward_history()<CR>]], { buffer = true })
    vim.keymap.set("i", "<C-k>", [[<Cmd>lua require("reacher").backward_history()<CR>]], { buffer = true })
    vim.keymap.set({ "n", "i" }, "<ESC>", [[<Cmd>lua require("reacher").cancel()<CR>]], { buffer = true })

    vim.keymap.set("n", "<CR>", [[<Cmd>lua require("reacher").finish()<CR>]], { buffer = true })
    vim.keymap.set("n", "q", [[<Cmd>lua require("reacher").cancel()<CR>]], { nowait = true, buffer = true })
    vim.keymap.set("n", "h", [[<Cmd>lua require("reacher").side_previous()<CR>]], { buffer = true })
    vim.keymap.set("n", "l", [[<Cmd>lua require("reacher").side_next()<CR>]], { buffer = true })
    vim.keymap.set("n", "j", [[<Cmd>lua require("reacher").next()<CR>]], { buffer = true })
    vim.keymap.set("n", "k", [[<Cmd>lua require("reacher").previous()<CR>]], { buffer = true })
    vim.keymap.set("n", "ga", [[<Cmd>lua require("reacher").side_first()<CR>]], { buffer = true })
    vim.keymap.set("n", "ge", [[<Cmd>lua require("reacher").side_last()<CR>]], { buffer = true })
    vim.keymap.set("n", "gg", [[<Cmd>lua require("reacher").first()<CR>]], { buffer = true })
    vim.keymap.set("n", "G", [[<Cmd>lua require("reacher").last()<CR>]], { buffer = true })
    vim.keymap.set("n", "gz", [[<Cmd>lua require("reacher").last()<CR>]], { buffer = true })
    vim.keymap.set("n", "w", [[<Cmd>lua require("reacher").next()<CR>]], { buffer = true })
    vim.keymap.set("n", "b", [[<Cmd>lua require("reacher").previous()<CR>]], { buffer = true })
    vim.keymap.set("n", "v", [[<Nop>]], { buffer = true })
    vim.keymap.set("n", "<Space>", [[<Cmd>lua require("reacher").finish()<CR>]], { buffer = true, nowait = true })
  end,
})
