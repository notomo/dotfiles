
function! s:packadd_once(name, group) abort
    execute 'packadd ' . a:name
    execute 'autocmd! ' a:group
endfunction

function! s:define_lazy_load(name, group, event, pattern) abort
    let args = join([a:name, a:group], "','")
    execute 'autocmd ' a:group . ' ' . a:event . ' ' . a:pattern . " call s:packadd_once('" . args . "')"
endfunction

function! s:add(name, options) abort
    let name = join(split(a:name, '/')[1:], '')
    let group = 'MyLazyLoad' . name
    execute 'augroup ' . group . ' | autocmd! | augroup END'

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

    call minpac#add(a:name, {'type': 'opt'})
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

if !has('nvim')
    finish
endif

call s:add('fszymanski/deoplete-emoji', {'ft' : 'markdown'})

call s:add('cocopon/pgmnt.vim', {'cmd' : 'PgmntDevInspect'})
nnoremap [exec]h :<C-u>PgmntDevInspect<CR>

call s:add('mattn/emmet-vim', {'ft' : ['css', 'html']})
call s:add('Shougo/context_filetype.vim', {'ft' : 'vue'})
