
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

call s:add('tmhedberg/matchit', {'ft' : ['html', 'smarty', 'vim', 'sql', 'php']})

call s:add('tyru/capture.vim', {'cmd' : 'Capture'})
nnoremap [exec]ci :<C-u>Capture<Space>
nnoremap [exec]cm :<C-u>Capture messages<CR>
nnoremap [exec]cv :<C-u>Capture version<CR>
nnoremap [exec]cs :<C-u>call notomo#vimrc#syntax_report()<CR>

call s:add('rhysd/vim-gfm-syntax', {'ft' : 'markdown'})

call s:add('fuenor/im_control.vim', {'event' : 'InsertEnter'})
let g:IM_CtrlMode = 4

call s:add('notomo/helpeek.vim', {'cmd': 'Helpeek*', 'depth': 0})
nnoremap [keyword]; :<C-u>Helpeek<CR>

call s:add('notomo/kiview', {'cmd': 'Kiview*', 'depth': 0})
source ~/.vim/rc/plugins/kiview.vim

call s:add('thinca/vim-qfreplace', {'cmd': 'Qfreplace'})
nnoremap [exec]Q :<C-u>Qfreplace<CR>

call s:add('thinca/vim-quickrun', {'cmd': 'QuickRun'})
nnoremap <silent> <Leader>Q :<C-u>call notomo#quickrun#execute()<CR>
xnoremap <silent> <Leader>Q :QuickRun -mode v<CR>
source ~/.vim/rc/plugins/quickrun.vim

call s:add('tyru/open-browser.vim', {'cmd': 'OpenBrowser*'})
nnoremap [browser] <Nop>
nmap [exec]b [browser]
xnoremap [browser] <Nop>
xmap [exec]b [browser]

nnoremap <expr> [browser]s ":\<C-u>OpenBrowserSearch " . expand('<cword>') . "\<CR>"
nnoremap [browser]o :<C-u>call _open_browser(expand('<cWORD>'))<CR>
nnoremap [browser]i :<C-u>OpenBrowserSearch<Space>

if executable('lemonade') && has('mac') && !empty($SSH_CLIENT)
    let g:openbrowser_browser_commands = [
    \ {'name': 'lemonade',
    \  'args': 'lemonade open {uri}'}
    \ ]
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

call s:add('notomo/vimited', {'cmd' : 'Vimited*', 'depth': 0})
xnoremap <Space><S-v> :VimitedSet<CR>
nnoremap <Space><C-v> :<C-u>VimitedClear<CR>

call s:add('notomo/tdd.vim', {'cmd' : 'TDD*', 'depth': 0})
source ~/.vim/rc/plugins/tdd.vim

call s:add('notomo/vimonga', {'cmd': 'Vimonga*', 'depth': 0})
source ~/.vim/rc/plugins/vimonga.vim

call s:add('ruanyl/vim-gh-line', {'cmd': 'GH'})
let g:gh_line_map_default = 0
let g:gh_line_blame_map_default = 0
let g:gh_always_interactive = 1
if !has('mac') && has('unix') && executable('xclip')
    let g:gh_open_command = 'fn() { echo "$@" | xclip -d :0 -i -selection c; }; fn '
elseif has('mac') && executable('lemonade')
    let g:gh_open_command = 'fn() { echo "$@" | lemonade copy; }; fn '
elseif has('win32')
    let g:gh_open_command = 'fn() { echo "$@" | win32yank -i --crlf; }; fn '
endif
nnoremap [yank]U :<C-u>YankGH<CR>
xnoremap [yank]U :YankGH<CR>

function! s:yank_and_echo(line1, line2) abort range
    if a:line1 == a:line2
        execute 'GH'
    else
        execute a:line1 . ',' . a:line2 . 'GH'
    endif
    let value = @+
    echomsg 'yank '. trim(value)
endfunction

command! -range YankGH call s:yank_and_echo(<line1>, <line2>)

call s:add('notomo/valtair', {'cmd': 'Valtair*', 'depth': 0})
source ~/.vim/rc/plugins/valtair.vim

if executable('node')
    call s:add('notomo/gesture.nvim', {'do' : '!npm run setup', 'cmd': 'Gesture*', 'depth': 0})
    noremap <silent> <LeftDrag> :<C-u>GestureDraw<CR>
    noremap <silent> <LeftRelease> :<C-u>GestureFinish<CR>
    source ~/.vim/rc/plugins/gesture.vim

    call s:add('notomo/ctrlb.nvim', {'do' : '!npm run setup', 'cmd': 'Ctrlb*', 'depth': 0})
    nnoremap <expr> [exec]cb ":\<C-u>CtrlbOpenLayout ~/dotfiles/vim/rc/plugins/ctrlb_layout.json\<CR>"
    nnoremap [exec]c<CR> :<C-u>CtrlbClearAll<CR>
    nnoremap [exec]cc :<C-u>CtrlbOpen ctrl<CR>
    source ~/.vim/rc/plugins/ctrlb.vim

    call s:add('mhartington/nvim-typescript', {'do': '!./install.sh', 'ft': 'typescript'})
    let g:nvim_typescript#signature_complete = 1
    let g:nvim_typescript#diagnostics_enable = 0
endif

if executable('python3.6') || executable('python3.7')
    call s:add('notomo/curstr.nvim', {'cmd': 'Curstr*', 'depth': 0})
    nnoremap <silent> [keyword]fo :<C-u>Curstr openable -action=open<CR>
    nnoremap <silent> [keyword]ft :<C-u>Curstr openable -action=tab_open<CR>
    nnoremap <silent> [keyword]fv :<C-u>Curstr openable -action=vertical_open<CR>
    nnoremap <silent> [keyword]fh :<C-u>Curstr openable -action=horizontal_open<CR>
    nnoremap <silent> [edit]s :<C-u>Curstr togglable<CR>
    source ~/.vim/rc/plugins/curstr.vim

    call s:add('numirias/semshi', {'ft': 'python'})
    let g:semshi#simplify_markup = v:false
    let g:semshi#tolerate_syntax_errors = v:false
    autocmd MyAuGroup FileType python call notomo#python#semshi_highlight()
endif

call s:add('neovim/nvim-lsp', {'ft' : ['rust', 'go', 'python']})
