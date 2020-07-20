autocmd MyAuGroup User ThettoSourceLoad call s:thetto()
function! s:thetto() abort
    lua << EOF
require('thetto/kind/directory').after = function(path)
  vim.api.nvim_command("Kiview -create -split=no")
end

require('thetto/source/file/mru').ignore_pattern = "\\v(^(gina|thetto|term|kiview)://|denite-filter$|\\[denite\\]-default$)"

local grep = require('thetto/source/grep')
grep.command = "pt"
grep.opts = {"--nogroup", "--nocolor", "--smart-case", "--ignore=.git", "--ignore=tags", "--hidden"}
grep.pattern_opt = ""
grep.recursive_opt = ""
grep.separator = "--"
EOF
endfunction

autocmd MyAuGroup FileType thetto call s:thetto_settings()
function! s:thetto_settings() abort
    nnoremap <buffer> <CR> :<C-u>ThettoDo<CR>
    nnoremap <buffer> dd :<C-u>ThettoDo move_to_input<CR><Esc>:<C-u>silent %delete _<CR>
    nnoremap <buffer> cc :<C-u>ThettoDo move_to_input<CR><Esc>:<C-u>silent %delete _<CR>:<C-u>ThettoDo move_to_input<CR>
    nnoremap <buffer> i :<C-u>ThettoDo move_to_input<CR><Right>
    nnoremap <buffer> I :<C-u>ThettoDo move_to_input<CR><Home>
    nnoremap <buffer> a :<C-u>ThettoDo move_to_input<CR>
    nnoremap <buffer> A :<C-u>ThettoDo move_to_input<CR><End>
    nnoremap <buffer> q :<C-u>ThettoDo quit<CR>
    nnoremap <buffer> o :<C-u>ThettoDo open<CR>
    nnoremap <buffer> sv :<C-u>ThettoDo vsplit_open<CR>
    nnoremap <buffer> t<Space> :<C-u>ThettoDo tab_open<CR>
    nnoremap <silent> <buffer> <expr> j line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent> <buffer> <expr> k line('.') == 1 ? 'G' : 'k'
    nnoremap <silent> <buffer> <2-LeftMouse> :<C-u>ThettoDo<CR>
endfunction

autocmd MyAuGroup FileType thetto-input call s:thetto_input_settings()
function! s:thetto_input_settings() abort
    nnoremap <buffer> <CR> :<C-u>ThettoDo<CR>
    inoremap <buffer> <CR> <Esc>:ThettoDo<CR>
    nnoremap <silent> <buffer> dd :<C-u>silent %delete _<CR>
    inoremap <silent> <buffer> jq <Esc>:ThettoDo quit<CR>
    nnoremap <buffer> j :<C-u>ThettoDo move_to_list<CR>
    nnoremap <buffer> k :<C-u>ThettoDo move_to_list<CR>
    nnoremap <buffer> q :<C-u>ThettoDo quit<CR>
    nnoremap <buffer> o :<C-u>ThettoDo open<CR>
    nnoremap <buffer> t<Space> :<C-u>ThettoDo tab_open<CR>
    inoremap <buffer> <C-u> <Cmd>lua require('notomo/insert').delete_prev()<CR>
endfunction

nnoremap [finder]R :<C-u>Thetto vim/runtimepath<CR>
nnoremap <Space>ur :<C-u>Thetto file/mru<CR>
nnoremap <Space>u<CR> :<C-u>Thetto --resume<CR>
nnoremap <Space>usf :<C-u>Thetto file/recursive<CR>
nnoremap <Space>usg :<C-u>Thetto file/recursive --target=project<CR>
nnoremap [finder]f :<C-u>Thetto file/in_dir<CR>
nnoremap [finder]h :<C-u>Thetto vim/help<CR>
nnoremap [finder]l :<C-u>Thetto line<CR>
nnoremap [finder]r :<C-u>Thetto directory/recursive --target=project<CR>
nnoremap [finder]v :<C-u>Thetto file/recursive --cwd=~/dotfiles<CR>
