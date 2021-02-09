
function! s:define_lazy_load(name, group, event, pattern) abort
    execute 'autocmd' a:group a:event a:pattern '++once packadd' a:name
endfunction

function! s:add(name, options) abort
    let name = join(split(a:name, '/')[1:], '')
    let group = 'MyLazyLoad' . name
    execute 'augroup' group '| autocmd! | augroup END'

    let options = {'type': 'opt'}
    if has_key(a:options, 'ft')
        let ft = a:options['ft']
        let filetypes = type(ft) == v:t_list ? join(ft, ',') : ft
        call s:define_lazy_load(name, group, 'FileType', filetypes)
    endif
    if has_key(a:options, 'cmd')
        let cmd = a:options['cmd']
        call s:define_lazy_load(name, group, 'CmdUndefined', cmd)
    endif
    if has_key(a:options, 'event')
        let event = a:options['event']
        call s:define_lazy_load(name, group, event, '*')
    endif
    if has_key(a:options, 'depth')
        let options['depth'] = a:options['depth']
    endif
    if has_key(a:options, 'do')
        let options['do'] = a:options['do']
    endif
    if has_key(a:options, 'module')
        call luaeval('require("notomo/hook").RequireHook.create(_A[1], _A[2])', [name, a:options['module']])
    endif

    call minpac#add(a:name, options)
endfunction

call s:add('h1mesuke/vim-alignta', {'cmd' : 'Alignta'})
xnoremap [alignta] <Nop>
xmap <Leader>a [alignta]
xnoremap [alignta]i :<C-u>'<,'>Alignta =><CR>
xnoremap [alignta]e :<C-u>'<,'>Alignta =<CR>
xnoremap [alignta], :<C-u>'<,'>Alignta ,<CR>
xnoremap [alignta]c :<C-u>'<,'>Alignta :<CR>
xnoremap [alignta]p :<C-u>'<,'>Alignta )<CR>
xnoremap [alignta]<Space> :<C-u>'<,'>Alignta <<0 \ <CR>

call s:add('lilydjwg/colorizer', {'cmd' : 'ColorHighlight'})

call s:add('AndrewRadev/linediff.vim', {'cmd' : '*Linediff'})
xnoremap [diff]l :Linediff<CR>

call s:add('tmhedberg/matchit', {'ft' : ['html', 'vim', 'sql']})

call s:add('fuenor/im_control.vim', {'event' : 'InsertEnter'})
let g:IM_CtrlMode = 4

call s:add('thinca/vim-qfreplace', {'cmd': 'Qfreplace'})
nnoremap [exec]Q :<C-u>Qfreplace<CR>

call s:add('tyru/open-browser.vim', {'cmd': 'OpenBrowser*'})
nnoremap [browser] <Nop>
nmap [exec]b [browser]
xnoremap [browser] <Nop>
xmap [exec]b [browser]

nnoremap <expr> [browser]s ":\<C-u>OpenBrowserSearch " . expand('<cword>') . "\<CR>"
nnoremap <expr> [browser]o ":\<C-u>OpenBrowser " . expand('<cWORD>') . "\<CR>"
nnoremap [browser]i :<C-u>OpenBrowserSearch<Space>

if !empty($SSH_CLIENT) && executable('lemonade') && has('mac')
    let g:openbrowser_browser_commands = [{'name': 'lemonade', 'args': 'lemonade open {uri}'}]
elseif executable('wslview')
    let g:openbrowser_browser_commands = [{'name': 'wslview', 'args': 'wslview {uri}'}]
endif

call s:add('notomo/minfiler.vim', {'cmd': 'Minfiler', 'depth': 0})
nnoremap [exec]F :<C-u>tabedit<CR>:Minfiler<CR>

if !has('nvim')
    finish
endif

call s:add('Shougo/context_filetype.vim', {'ft' : 'vue'})

call s:add('notomo/tdd.vim', {'cmd' : 'TDD*', 'depth': 0})
source ~/.vim/rc/plugins/tdd.vim

call s:add('notomo/vimonga', {'cmd': 'Vimonga*', 'depth': 0})
source ~/.vim/rc/plugins/vimonga.vim

call s:add('notomo/curstr.nvim', {'cmd': 'Curstr*', 'depth': 0})
nnoremap <silent> [keyword]fo :<C-u>Curstr openable -action=open<CR>
nnoremap <silent> [keyword]ft :<C-u>Curstr openable -action=tab_open<CR>
nnoremap <silent> [keyword]fv :<C-u>Curstr openable -action=vertical_open<CR>
nnoremap <silent> [keyword]fh :<C-u>Curstr openable -action=horizontal_open<CR>
nnoremap <silent> [edit]s :<C-u>Curstr togglable<CR>
nnoremap <Space>rj :<C-u>Curstr print -action=append<CR>j
nnoremap [edit]J :<C-u>Curstr range -action=join<CR>
xnoremap [edit]J :Curstr range -action=join<CR>
autocmd MyAuGroup User CurstrSourceLoad lua dofile(vim.fn.expand('~/dotfiles/vim/lua/notomo/curstr.lua'))

call s:add('notomo/nvimtool', {'cmd' : 'NvimTool*', 'depth': 0})

call s:add('notomo/gesture.nvim', {'cmd': 'Gesture*', 'depth': 0})
source ~/.vim/rc/plugins/gesture.vim

call s:add('notomo/flompt.nvim', {'module': 'flompt', 'depth': 0})
source ~/.vim/rc/plugins/flompt.vim

call s:add('notomo/thetto.nvim', {'cmd' : 'Thetto*', 'depth': 0})
source ~/.vim/rc/plugins/thetto.vim

call s:add('notomo/counteria.nvim', {'cmd' : 'Counteria*', 'depth': 0})

call s:add('notomo/hita.nvim', {'cmd' : 'Hita*', 'depth': 0})
nnoremap gj :<C-u>Hita downside_line<CR>
nnoremap gk :<C-u>Hita upside_line<CR>
nnoremap gn :<C-u>Hita line<CR>
nnoremap g<CR> :<C-u>Hita search<CR>

call s:add('neovim/nvim-lspconfig', {'module': 'lspconfig'})

call s:add('notomo/kivi.nvim', {'cmd': 'Kivi*', 'depth': 0})
source ~/.vim/rc/plugins/kivi.vim

call s:add('notomo/reacher.nvim', {'depth': 0, 'module': 'reacher'})
source ~/.vim/rc/plugins/reacher.vim

call s:add('dart-lang/dart-vim-plugin', {'ft' : 'dart'})
call s:add('thosakwe/vim-flutter', {'ft' : 'dart'})

call s:add('notomo/cmdbuf.nvim', {'depth': 0, 'module': 'cmdbuf'})
nnoremap Q <Cmd>lua require("cmdbuf").split_open(vim.o.cmdwinheight)<CR>
cnoremap <C-q> <Cmd>lua require('cmdbuf').split_open(vim.o.cmdwinheight, {line = vim.fn.getcmdline(), column = vim.fn.getcmdpos()})<CR><C-c>
augroup cmdbuf_setting
  autocmd!
  autocmd User CmdbufNew call s:cmdbuf()
augroup END
function! s:cmdbuf() abort
    setlocal bufhidden=wipe
    nnoremap <buffer> q <Cmd>quit<CR>
    nnoremap <buffer> dd <Cmd>lua require('cmdbuf').delete()<CR>
    xnoremap <buffer> D :lua require('cmdbuf').delete({vim.api.nvim_buf_get_mark(0, "<")[1], vim.api.nvim_buf_get_mark(0, ">")[1]})<CR>
endfunction
