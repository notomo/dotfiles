
function! s:add(name, options) abort
    let name = join(split(a:name, '/')[1:], '')

    if has_key(a:options, 'ft')
        let ft = a:options['ft']
        let filetypes = type(ft) == v:t_list ? join(ft, ',') : ft
        execute 'autocmd MyAuGroup FileType ' . filetypes . ' packadd ' . name
    endif
    if has_key(a:options, 'cmd')
        let cmd = a:options['cmd']
        execute 'autocmd MyAuGroup CmdUndefined ' . cmd . ' packadd ' . name
    endif
    if has_key(a:options, 'event')
        let event = a:options['event']
        execute 'autocmd MyAuGroup ' . event . ' * packadd ' . name
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

call s:add('lilydjwg/colorizer', {'cmd' : 'ColorToggle', 'ft' : ['javascript', 'css', 'html', 'vim']})
nnoremap [exec]C :<C-u>ColorToggle<CR>

call s:add('AndrewRadev/linediff.vim', {'cmd' : '*Linediff'})
xnoremap [diff]l :Linediff<CR>

call s:add('tmhedberg/matchit', {'ft' : ['html', 'smarty', 'vim', 'sql', 'php']})

call s:add('tyru/capture.vim', {'cmd' : 'Capture'})
nnoremap [exec]ci :<C-u>Capture<Space>
nnoremap [exec]cm :<C-u>Capture messages<CR>
nnoremap [exec]cv :<C-u>Capture version<CR>
nnoremap [exec]cs :<C-u>call notomo#vimrc#syntax_report()<CR>

call s:add('plasticboy/vim-markdown', {'ft' : 'markdown'})
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0

call s:add('thinca/vim-textobj-function-javascript', {'ft' : 'javascript'})

call s:add('fuenor/im_control.vim', {'event' : 'InsertEnter'})
let g:IM_CtrlMode = 4

if !has('nvim')
    finish
endif

call s:add('zchee/deoplete-jedi', {'ft' : 'python'})
if has('mac')
    let g:deoplete#sources#jedi#python_path = '/usr/local/bin/python3'
else
    let g:deoplete#sources#jedi#python_path = '/usr/bin/python3'
endif

call s:add('zchee/deoplete-go', {'ft' : 'go', 'do' : executable('make') ? 'silent! !make' : '' })
if has('win32')
    let g:deoplete#sources#go#gocode_binary = $GOPATH . '\bin\gocode.exe'
else
    let g:deoplete#sources#go#gocode_binary = $GOPATH . '/bin/gocode'
endif

call s:add('fszymanski/deoplete-emoji', {'ft' : 'markdown'})

call s:add('zchee/deoplete-clang', {'ft' : 'c'})
let g:deoplete#sources#clang#libclang_path = '/usr/lib64/llvm/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'

call s:add('mhartington/nvim-typescript', {'ft' : 'typescript', 'do' : 'silent! !./install.sh' })

call s:add('fatih/vim-go', {'ft' : 'go', 'do' : 'GoInstallBinaries' })
let g:go_auto_type_info = 0
let g:go_auto_sameids = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_fmt_autosave = 0
let g:go_list_type = 'quickfix'
let g:go_snippet_engine = ''
let g:go_gocode_unimported_packages = 1
let g:go_template_autocreate = 0
let g:go_info_mode = 'guru'

call s:add('carlitux/deoplete-ternjs', {'ft' : 'javascript'})
let g:deoplete#sources#ternjs#timeout = 1
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#depths = 1
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#ternjs#omit_object_prototype = 0
let g:deoplete#sources#ternjs#include_keywords = 1

call s:add('cocopon/pgmnt.vim', {'cmd' : 'PgmntDevInspect'})
nnoremap [exec]h :<C-u>PgmntDevInspect<CR>

call s:add('othree/yajs.vim', {'ft' : 'javascript'})
call s:add('OrangeT/vim-csharp', {'ft' : 'cs'})

call s:add('octol/vim-cpp-enhanced-highlight', {'ft' : 'cpp'})
call s:add('thinca/vim-template', {'cmd' : 'TemplateLoad'})

call s:add('mattn/emmet-vim', {'ft' : ['css', 'html']})
call s:add('Shougo/context_filetype.vim', {'ft' : 'vue'})
call s:add('kana/vim-filetype-haskell', {'ft' : 'haskell'})
