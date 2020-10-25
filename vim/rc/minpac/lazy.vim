
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

    call minpac#add(a:name, options)
endfunction

if has('gui') && !has('nvim')
    call s:add('tyru/restart.vim', {'cmd' : 'Restart'})
    nnoremap [exec]R :<C-u>Restart<CR>
    let g:restart_sessionoptions = 'curdir,help,tabpages'
endif

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

call s:add('rhysd/vim-gfm-syntax', {'ft' : 'markdown'})

call s:add('fuenor/im_control.vim', {'event' : 'InsertEnter'})
let g:IM_CtrlMode = 4

call s:add('notomo/kiview', {'cmd': 'Kiview*', 'depth': 0, 'do': '!make build'})
source ~/.vim/rc/plugins/kiview.vim

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

" for kiview error debug
call s:add('notomo/minfiler.vim', {'cmd': 'Minfiler', 'depth': 0})
nnoremap [exec]F :<C-u>tabedit<CR>:Minfiler<CR>

if !has('nvim')
    finish
endif

call s:add('cocopon/inspecthi.vim', {'cmd' : 'Inspecthi'})
nnoremap [exec]h :<C-u>Inspecthi<CR>

call s:add('mattn/emmet-vim', {'ft' : ['css', 'html']})
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

call s:add('notomo/flompt.nvim', {'cmd' : 'Flompt', 'depth': 0})
source ~/.vim/rc/plugins/flompt.vim

call s:add('notomo/thetto.nvim', {'cmd' : 'Thetto*', 'depth': 0})
source ~/.vim/rc/plugins/thetto.vim

call s:add('notomo/counteria.nvim', {'cmd' : 'Counteria*', 'depth': 0})

call s:add('notomo/hita.nvim', {'cmd' : 'Hita*', 'depth': 0})
nnoremap gj :<C-u>Hita downside_line<CR>
nnoremap gk :<C-u>Hita upside_line<CR>
nnoremap gn :<C-u>Hita line<CR>
nnoremap gw :<C-u>Hita window_word<CR>
nnoremap g<CR> :<C-u>Hita search<CR>

call s:add('neovim/nvim-lsp', {})

call s:add('notomo/kivi.nvim', {'cmd': 'Kivi*', 'depth': 0})
source ~/.vim/rc/plugins/kivi.vim
