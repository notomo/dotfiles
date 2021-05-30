call minpac#add('k-takata/minpac', {'type': 'opt'})
nnoremap [exec]U :<C-u>call minpac#update('', {'do': 'call notomo#vimrc#update_rplugin_runtimepath()'})<CR>
nnoremap [exec]R :<C-u>call notomo#vimrc#clean()<CR>

call minpac#add('kana/vim-textobj-user')
call minpac#add('kana/vim-operator-user')

call minpac#add('kana/vim-submode')
let g:submode_keep_leaving_key = 1
let g:submode_timeout = 0

call minpac#add('thinca/vim-zenspace')
let g:zenspace#default_mode = 'on'

call minpac#add('LeafCage/yankround.vim')
let g:yankround_use_region_hl = 1
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

call minpac#add('Shougo/neosnippet.vim')
xmap <Space>S <Plug>(neosnippet_expand_target)
nnoremap [file]s :<C-u>NeoSnippetEdit<CR>
imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" : "\<TAB>"
let g:neosnippet#snippets_directory = '~/.vim/snippets/'
let g:neosnippet#disable_runtime_snippets = {'_' : 1}
function! s:complete() abort
    if neosnippet#expandable()
        return "\<Plug>(neosnippet_expand)"
    endif
    if exists('v:completed_item') && !empty(v:completed_item)
        return "\<C-y>\<Plug>(neosnippet_expand)"
    endif
    return "\<C-n>\<C-y>\<Plug>(neosnippet_expand)"
endfunction
imap <expr> j<Space>o <SID>complete()

call minpac#add('tpope/vim-repeat')

call minpac#add('kana/vim-smartword')
nmap w <Plug>(smartword-w)
xmap w <Plug>(smartword-w)
omap w <Plug>(smartword-w)
nmap b <Plug>(smartword-b)
xmap b <Plug>(smartword-b)
omap b <Plug>(smartword-b)
nmap e <Plug>(smartword-e)
xmap e <Plug>(smartword-e)
omap e <Plug>(smartword-e)

call minpac#add('rhysd/vim-color-spring-night')
let g:spring_night_kill_italic = 1
let g:spring_night_high_contrast = 0

call minpac#add('lambdalisue/gina.vim')

call minpac#add('itchyny/lightline.vim')

call minpac#add('kana/vim-textobj-entire')
omap ae <Plug>(textobj-entire-a)
omap ie <Plug>(textobj-entire-i)
xmap ae <Plug>(textobj-entire-a)
xmap ie <Plug>(textobj-entire-i)

call minpac#add('osyo-manga/vim-textobj-multiblock')
omap aj <Plug>(textobj-multiblock-a)
omap ij <Plug>(textobj-multiblock-i)
xmap aj <Plug>(textobj-multiblock-a)
xmap ij <Plug>(textobj-multiblock-i)
let g:textobj_multiblock_blocks = [
    \ [ '(', ')' ],
    \ [ '[', ']' ],
    \ [ '{', '}' ],
    \ [ '<', '>' ],
    \ [ '"', '"'],
    \ [ "'", "'"],
    \ [ '`', '`', 1],
\ ]

call minpac#add('osyo-manga/vim-operator-blockwise')
nmap [operator]c <Plug>(operator-blockwise-change)
nmap [operator]d <Plug>(operator-blockwise-delete)
nmap [operator]y <Plug>(operator-blockwise-yank)

call minpac#add('osyo-manga/vim-textobj-blockwise')

call minpac#add('kana/vim-textobj-line')
xmap ag <Plug>(textobj-line-a)
xmap ig <Plug>(textobj-line-i)
omap ag <Plug>(textobj-line-a)
omap ig <Plug>(textobj-line-i)

call minpac#add('bkad/CamelCaseMotion')
nmap <Leader>w <Plug>CamelCaseMotion_w
xmap <Leader>w <Plug>CamelCaseMotion_w
omap <Leader>w <Plug>CamelCaseMotion_w
nmap <Leader>b <Plug>CamelCaseMotion_b
xmap <Leader>b <Plug>CamelCaseMotion_b
omap <Leader>b <Plug>CamelCaseMotion_b
nmap <Leader>e <Plug>CamelCaseMotion_e
xmap <Leader>e <Plug>CamelCaseMotion_e
omap <Leader>e <Plug>CamelCaseMotion_e

call minpac#add('kana/vim-operator-replace')
nmap r <Plug>(operator-replace)
xmap r <Plug>(operator-replace)
omap r <Plug>(operator-replace)
onoremap <Plug>(builtin-gn) gn
nnoremap <Plug>(builtin-/) /
nnoremap <Plug>(builtin-N) N
nmap [edit]n *<Plug>(builtin-N)<Plug>(operator-replace)<Plug>(builtin-gn)
xmap <expr> [edit]n "\<ESC><Plug>(builtin-/)\<C-r>=<SID>search()\<CR>\<CR><Plug>(builtin-N)<Plug>(operator-replace)<Plug>(builtin-gn)"
xnoremap <expr> [edit]d "\<ESC>/\<C-r>=<SID>search()\<CR>\<CR>N\"_cgn"
function! s:search() abort
    let tmp = @"
    normal! gv""y
    let [text, @"] = [escape(@", '\/'), tmp]
    return '\V' .. substitute(text, "\n", '\\n', 'g')
endfunction

call minpac#add('osyo-manga/vim-textobj-from_regexp')
omap <expr> i. textobj#from_regexp#mapexpr('\.\zs.\{-}\ze\.')
xmap <expr> i. textobj#from_regexp#mapexpr('\.\zs.\{-}\ze\.')
omap <expr> a. textobj#from_regexp#mapexpr('\..\{-1,}\(\.\)\@=')
xmap <expr> a. textobj#from_regexp#mapexpr('\..\{-1,}\(\.\)\@=')

omap <expr> ix textobj#from_regexp#mapexpr('\v\*\zs[^*]+\ze\*')
xmap <expr> ix textobj#from_regexp#mapexpr('\v\*\zs[^*]+\ze\*')
omap <expr> ax textobj#from_regexp#mapexpr('\*.\{-1,}\(*\)\@=')
xmap <expr> ax textobj#from_regexp#mapexpr('\*.\{-1,}\(*\)\@=')

omap <expr> i/ textobj#from_regexp#mapexpr('/\zs.\{-}\ze/')
xmap <expr> i/ textobj#from_regexp#mapexpr('/\zs.\{-}\ze/')
omap <expr> a/ textobj#from_regexp#mapexpr('/.\{-1,}\(/\)\@=')
xmap <expr> a/ textobj#from_regexp#mapexpr('/.\{-1,}\(/\)\@=')

call minpac#add('rhysd/vim-operator-surround')
source ~/.vim/rc/plugins/operator-surround.vim

call minpac#add('tyru/caw.vim')
nmap <Space>c <Plug>(caw:hatpos:toggle:operator)_
xmap <Space>c <Plug>(caw:hatpos:toggle:operator)
nmap <Space><Space>c <Plug>(caw:wrap:toggle:operator)_
xmap <Space><Space>c <Plug>(caw:wrap:toggle:operator)
let g:caw_no_default_keymappings = 1

call minpac#add('haya14busa/vim-edgemotion')
nmap gJ <Plug>(edgemotion-j)
xmap gJ <Plug>(edgemotion-j)
omap gJ <Plug>(edgemotion-j)
nmap gK <Plug>(edgemotion-k)
xmap gK <Plug>(edgemotion-k)
omap gK <Plug>(edgemotion-k)

call minpac#add('mhinz/vim-signify')
nmap [git]j <Plug>(signify-next-hunk)zz
nmap [git]k <Plug>(signify-prev-hunk)zz
nnoremap [git]t :<C-u>SignifyToggle<CR>
let g:signify_disable_by_default = 0

call minpac#add('junegunn/vim-emoji')

call minpac#add('thinca/vim-themis')
call minpac#add('notomo/vusted', {'depth': 0})
call minpac#add('notomo/virtes.nvim', {'depth': 0})
call minpac#add('notomo/genvdoc', {'depth': 0})

autocmd MyAuGroup FileType typescriptreact set filetype=typescript.tsx

if has('unix')
    call minpac#add('lambdalisue/suda.vim')
    let g:suda_startup = 1
    nnoremap [file]W :<C-u>write suda://%<CR>
endif

if !has('win32')
    call minpac#add('ujihisa/neco-look')
endif

call minpac#add('w0rp/ale')
source ~/.vim/rc/plugins/ale.vim

if executable('python3')
    call minpac#add('Shougo/deoplete.nvim')
    let g:deoplete#enable_at_startup = 1
endif

call minpac#add('Shougo/deoplete-lsp')

call minpac#add('voldikss/vim-translator')
nnoremap [keyword]T :<C-u>Translate<CR>
xmap T <Plug>TranslateV
let g:translator_target_lang = 'ja'
let g:translator_default_engines = ['google']
let g:translator_history_enable = 1

call minpac#add('notomo/suball.vim', {'depth': 0})
nnoremap <expr> [substitute]aw ':%' . suball#input(expand('<cword>'), "")
nnoremap <expr> [substitute]ay ':%' . suball#input(@+, "")

call minpac#add('notomo/searcho.nvim', {'depth': 0})
source ~/.vim/rc/plugins/searcho.vim

call minpac#add('notomo/wintablib.nvim', {'depth': 0})
source ~/.vim/rc/plugins/wintablib.vim

call minpac#add('tbastos/vim-lua')

call minpac#add('notomo/lreload.nvim', {'depth': 0})

call minpac#add('nanotee/luv-vimdocs')

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
        call luaeval('require("notomo/hook").RequireHook.create(_A[1], _A[2], _A[3])', [name, a:options['module'], get(a:options, 'post_hook_file', v:null)])
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

call s:add('Shougo/context_filetype.vim', {'ft' : 'vue'})

call s:add('notomo/tdd.vim', {'cmd' : 'TDD*', 'depth': 0})
source ~/.vim/rc/plugins/tdd.vim

call s:add('notomo/vimonga', {'cmd': 'Vimonga*', 'depth': 0})
source ~/.vim/rc/plugins/vimonga.vim

call s:add('notomo/curstr.nvim', {'module': 'curstr', 'post_hook_file': '~/dotfiles/vim/lua/notomo/curstr.lua', 'depth': 0})
nnoremap <silent> [keyword]fo <Cmd>lua require("curstr").execute("openable", {action = "open"})<CR>
nnoremap <silent> [keyword]ft <Cmd>lua require("curstr").execute("openable", {action = "tab_open"})<CR>
nnoremap <silent> [keyword]fv <Cmd>lua require("curstr").execute("openable", {action = "vertical_open"})<CR>
nnoremap <silent> [keyword]fh <Cmd>lua require("curstr").execute("openable", {action = "horizontal_open"})<CR>
nnoremap <silent> [edit]s <Cmd>lua require("curstr").execute("togglable")<CR>
nnoremap <Space>rj <Cmd>lua require("curstr").execute("print", {action = "append"})<CR>j
nnoremap [edit]J <Cmd>lua require("curstr").execute("range", {action = "join"})<CR>
xnoremap [edit]J <Cmd>lua require("curstr").execute("range", {action = "join"})<CR>
lua << EOF
require("lreload").enable("curstr", {
  post_hook = function()
    dofile(vim.fn.expand("~/dotfiles/vim/lua/notomo/curstr.lua"))
  end,
})
EOF

call s:add('notomo/nvimtool', {'module' : 'nvimtool', 'depth': 0})

call s:add('notomo/gesture.nvim', {'module': 'gesture', 'depth': 0})
source ~/.vim/rc/plugins/gesture.vim

call s:add('notomo/flompt.nvim', {'module': 'flompt', 'depth': 0})
source ~/.vim/rc/plugins/flompt.vim

call s:add('notomo/thetto.nvim', {'cmd' : 'Thetto*', 'depth': 0})
source ~/.vim/rc/plugins/thetto.vim

call s:add('notomo/counteria.nvim', {'cmd' : 'Counteria*', 'depth': 0})

call s:add('neovim/nvim-lspconfig', {'module': 'lspconfig'})

call s:add('notomo/kivi.nvim', {'module': 'kivi', 'depth': 0})
source ~/.vim/rc/plugins/kivi.vim

call s:add('notomo/reacher.nvim', {'depth': 0, 'module': 'reacher'})
source ~/.vim/rc/plugins/reacher.vim

call s:add('dart-lang/dart-vim-plugin', {'ft' : 'dart'})
call s:add('thosakwe/vim-flutter', {'ft' : 'dart'})

call s:add('notomo/cmdbuf.nvim', {'depth': 0, 'module': 'cmdbuf'})
source ~/.vim/rc/plugins/cmdbuf.vim

call s:add('notomo/filetypext.nvim', {'depth': 0, 'module': 'filetypext'})
nnoremap [exec]; <Cmd>lua vim.fn["notomo#vimrc#open_sandbox"](require("filetypext").detect({bufnr = 0})[1], vim.bo.filetype ~= '' and vim.bo.filetype or "markdown")<CR>

call s:add('notomo/cmdhndlr.nvim', {'depth': 0, 'module': 'cmdhndlr'})
xnoremap <Leader>Q <Cmd>lua require("cmdhndlr").run()<CR>
