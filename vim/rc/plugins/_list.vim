
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
        call luaeval('require("notomo.hook").RequireHook.create(_A[1], _A[2], _A[3])', [name, a:options['module'], get(a:options, 'post_hook_file', v:null)])
    endif

    call minpac#add(a:name, options)
endfunction

call minpac#add('k-takata/minpac', {'type': 'opt'})
nnoremap [exec]U <Cmd>call minpac#update()<CR>

call minpac#add('kana/vim-textobj-user')

call minpac#add('kana/vim-submode')
let g:submode_keep_leaving_key = 1
let g:submode_timeout = 0

call minpac#add('thinca/vim-zenspace')
let g:zenspace#default_mode = 'on'

call minpac#add('LeafCage/yankround.vim')
source ~/dotfiles/vim/rc/plugins/yankround.vim

call minpac#add('kana/vim-smartword')
source ~/dotfiles/vim/rc/plugins/smartword.vim

call minpac#add('rhysd/vim-color-spring-night')
let g:spring_night_kill_italic = 1
let g:spring_night_high_contrast = 0

call minpac#add('lambdalisue/gina.vim')

call minpac#add('itchyny/lightline.vim')

call minpac#add('kana/vim-textobj-entire')
source ~/dotfiles/vim/rc/plugins/textobj-entire.vim

call minpac#add('osyo-manga/vim-textobj-blockwise')

call minpac#add('kana/vim-textobj-line')
source ~/dotfiles/vim/rc/plugins/textobj-line.vim

call minpac#add('bkad/CamelCaseMotion')
source ~/dotfiles/vim/rc/plugins/camelcasemotion.vim

call minpac#add('osyo-manga/vim-textobj-from_regexp')
source ~/.vim/rc/plugins/textobj-from_regexp.vim

call minpac#add('haya14busa/vim-edgemotion')
source ~/.vim/rc/plugins/edgemotion.vim

call minpac#add('mhinz/vim-signify')
source ~/.vim/rc/plugins/signify.vim

call minpac#add('junegunn/vim-emoji')

call minpac#add('notomo/vusted', {'depth': 0})
call minpac#add('notomo/virtes.nvim', {'depth': 0})
call minpac#add('notomo/genvdoc', {'depth': 0})

if has('unix')
    call minpac#add('lambdalisue/suda.vim')
    let g:suda_startup = 1
    nnoremap [file]W <Cmd>write suda://%<CR>
endif

call minpac#add('w0rp/ale')
source ~/.vim/rc/plugins/ale.vim

call minpac#add('voldikss/vim-translator')
source ~/.vim/rc/plugins/translator.vim

call minpac#add('notomo/searcho.nvim', {'depth': 0})
source ~/.vim/rc/plugins/searcho.vim

call minpac#add('notomo/wintablib.nvim', {'depth': 0})
source ~/.vim/rc/plugins/wintablib.vim

call minpac#add('tbastos/vim-lua')

call minpac#add('notomo/lreload.nvim', {'depth': 0})

call minpac#add('nanotee/luv-vimdocs')

call minpac#add('hrsh7th/nvim-cmp')
luafile ~/.vim/lua/notomo/cmp.lua

call minpac#add('hrsh7th/cmp-nvim-lsp')
call minpac#add('hrsh7th/cmp-buffer')
call minpac#add('hrsh7th/cmp-path')
call minpac#add('hrsh7th/cmp-nvim-lua')
call minpac#add('notomo/cmp-neosnippet')

call s:add('AndrewRadev/linediff.vim', {'cmd' : '*Linediff'})
xnoremap [diff]l :Linediff<CR>

call s:add('tmhedberg/matchit', {'ft' : ['html', 'vim', 'sql']})

call s:add('thinca/vim-qfreplace', {'cmd': 'Qfreplace'})

call s:add('tyru/open-browser.vim', {'cmd': 'OpenBrowser*'})
source ~/.vim/rc/plugins/open-browser.vim

call s:add('Shougo/context_filetype.vim', {'ft' : 'vue'})

call s:add('notomo/vimonga', {'cmd': 'Vimonga*', 'depth': 0})
source ~/.vim/rc/plugins/vimonga.vim

call s:add('notomo/curstr.nvim', {'module': 'curstr', 'post_hook_file': '~/dotfiles/vim/lua/notomo/curstr.lua', 'depth': 0})
source ~/.vim/rc/plugins/curstr.vim

call s:add('notomo/nvimtool', {'module' : 'nvimtool', 'depth': 0})

call s:add('notomo/piemenu.nvim', {'module': 'piemenu', 'post_hook_file': '~/dotfiles/vim/lua/notomo/piemenu.lua', 'depth': 0})
source ~/.vim/rc/plugins/piemenu.vim

call s:add('notomo/gesture.nvim', {'module': 'gesture', 'post_hook_file': '~/dotfiles/vim/lua/notomo/gesture.lua', 'depth': 0})
source ~/.vim/rc/plugins/gesture.vim

call s:add('notomo/flompt.nvim', {'module': 'flompt', 'depth': 0})
source ~/.vim/rc/plugins/flompt.vim

call s:add('notomo/thetto.nvim', {'module' : 'thetto', 'post_hook_file': '~/dotfiles/vim/lua/notomo/thetto.lua', 'depth': 0})
source ~/.vim/rc/plugins/thetto.vim

call s:add('neovim/nvim-lspconfig', {'module': 'lspconfig'})

call s:add('notomo/kivi.nvim', {'module': 'kivi', 'depth': 0})
source ~/.vim/rc/plugins/kivi.vim

call s:add('notomo/reacher.nvim', {'depth': 0, 'module': 'reacher'})
source ~/.vim/rc/plugins/reacher.vim

call s:add('dart-lang/dart-vim-plugin', {'ft' : 'dart'})

call s:add('notomo/cmdbuf.nvim', {'depth': 0, 'module': 'cmdbuf'})
source ~/.vim/rc/plugins/cmdbuf.vim

call s:add('notomo/filetypext.nvim', {'depth': 0, 'module': 'filetypext'})
nnoremap [exec]; <Cmd>lua vim.fn["notomo#vimrc#open_sandbox"](require("filetypext").detect({bufnr = 0})[1], vim.bo.filetype ~= '' and vim.bo.filetype or "markdown")<CR>

call s:add('notomo/cmdhndlr.nvim', {'depth': 0, 'module': 'cmdhndlr'})
source ~/.vim/rc/plugins/cmdhndlr.vim

call s:add('notomo/suball.nvim', {'depth': 0, 'module': 'suball'})
source ~/.vim/rc/plugins/suball.vim

call s:add('nvim-treesitter/nvim-treesitter', {'cmd' : 'TS*'})
call s:add('nvim-treesitter/nvim-treesitter-textobjects', {'cmd' : 'TS*', 'post_hook_file': '~/dotfiles/vim/lua/notomo/treesitter.lua'})

call s:add('notomo/aliaser.nvim', {'depth': 0, 'post_hook_file': '~/dotfiles/vim/lua/notomo/aliaser.lua', 'module': 'aliaser'})
lua << EOF
require("lreload").enable("aliaser", {
  post_hook = function()
    dofile(vim.fn.expand("~/dotfiles/vim/lua/notomo/aliaser.lua"))
  end,
})
EOF

call s:add('tpope/vim-repeat', {'event' : 'VimEnter'})

call s:add('kana/vim-operator-user', {'event' : 'VimEnter'})

call s:add('osyo-manga/vim-textobj-multiblock', {'event' : 'BufLeave'})
source ~/dotfiles/vim/rc/plugins/textobj-multiblock.vim

call s:add('Shougo/neosnippet.vim', {'event' : 'VimEnter'})
source ~/dotfiles/vim/rc/plugins/neosnippet.vim

call s:add('osyo-manga/vim-operator-blockwise', {'event' : 'VimEnter'})
source ~/dotfiles/vim/rc/plugins/operator-blockwise.vim

call s:add('kana/vim-operator-replace', {'event' : 'VimEnter'})
source ~/dotfiles/vim/rc/plugins/operator-replace.vim

call s:add('rhysd/vim-operator-surround', {'event' : 'VimEnter'})
source ~/.vim/rc/plugins/operator-surround.vim

call s:add('tyru/caw.vim', {'event' : 'FileType'})
source ~/.vim/rc/plugins/caw.vim
