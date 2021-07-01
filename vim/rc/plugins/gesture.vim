lua << EOF
require("lreload").enable("gesture", {
  post_hook = function()
    dofile(vim.fn.expand("~/dotfiles/vim/lua/notomo/gesture.lua"))
  end,
})
EOF

nnoremap <silent> <LeftDrag> <Cmd>lua require("gesture").draw()<CR>
nnoremap <silent> <LeftRelease> <Cmd>lua require("gesture").finish()<CR>
