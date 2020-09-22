Guifont! MeiryoKe_Gothic:h14
GuiTabline 0
GuiPopupmenu 0
call GuiWindowMaximized(1)

nnoremap <Space>R :<C-u>call jobstart('nvim-qt.exe', {'detach': v:true})<CR>:quitall<CR>
