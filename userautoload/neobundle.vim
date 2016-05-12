
" vim起動時のみruntimepathにneobundle.vimを追加
if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim
    set runtimepath+=~/.vim/
    set runtimepath+=~/.vim/after
endif

" neobundle.vimの初期化 
" NeoBundleを更新するための設定
call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundleLazy 'Yggdroot/indentLine',{
\   'autoload':{
\       'filetypes':['python','php']
\   }
\}

NeoBundleLazy 'Shougo/neocomplete.vim',{
\   'on_i' : 1
\}

NeoBundleLazy 'Shougo/neosnippet',{
\   'on_i' : 1
\}

NeoBundleLazy 'Shougo/neosnippet-snippets',{
\   'depends' : ['neosnippet'],
\}

NeoBundleLazy 'davidhalter/jedi-vim',{
\   'autoload':{
\       'filetypes':['python']
\   } 
\}

NeoBundleLazy 'joonty/vdebug',{
\   'autoload':{
\       'filetypes':['php']
\   }
\}

NeoBundleLazy "tyru/caw.vim",{
\   'autoload':{
\       'mappings':['<Plug>(caw:hatpos:toggle)']
\   }
\}

NeoBundleLazy 'thinca/vim-quickrun',{
\   'autoload':{
\       'commands':['QuickRun'],
\       'mappings':['<Plug>(quickrun)']
\   }
\}

NeoBundleLazy 'fuenor/im_control.vim',{
\   'on_i' : 1
\}

NeoBundleLazy 'Shougo/vimshell',{
\   'autoload':{
\       'commands':['VimShell','VimShellTab','VimShellCreate','VimShellBufferDir','VimShellInteractive','VimShellSendString']
\   }
\}

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

NeoBundleLazy 'thinca/vim-ref',{
\   'autoload':{
\       'mappings':['<Plug>(ref-keyword)']
\   }
\}

NeoBundleLazy 'Shougo/unite.vim',{
\   'autoload':{
\       'commands':['Unite','UniteBookmarkAdd','UniteWithBufferDir','UniteWithCursorWord']
\   }
\}

NeoBundleLazy 'Shougo/neomru.vim',{
\   'autoload':{
\       'on_source': 'unite.vim'
\   }
\}

NeoBundleLazy 'tacroe/unite-mark',{
\   'autoload':{
\       'on_source': 'unite.vim'
\   }
\}

NeoBundleLazy 'Shougo/unite-outline',{
\   'autoload':{
\       'on_source': 'unite.vim'
\   }
\}

NeoBundleLazy 'kmnk/vim-unite-giti',{
\   'autoload':{
\       'on_source':['unite.vim']
\   }
\}

NeoBundleLazy 'tsukkee/unite-tag',{
\   'autoload':{
\       'on_source': 'unite.vim'
\   }
\}

NeoBundleLazy 'scrooloose/syntastic',{
\   'autoload':{
\       'filetypes':['python','php']
\   }
\}

NeoBundleLazy 'Shougo/vimfiler.vim',{
\   'autoload':{
\       'commands':['VimFilerBufferDir']
\   }
\}

NeoBundleLazy 'LeafCage/qutefinger.vim',{
\   'autoload':{
\       'mappings':['<Plug>(qutefinger-toggle-mode)','<Plug>(qutefinger-next)','<Plug>(qutefinger-prev)','<Plug>(qutefinger-toggle-win)','<Plug>(qutefinger-first)']
\   }
\}

NeoBundleLazy 'Lokaltog/vim-easymotion',{
\   'autoload':{
\       'mappings':['<Plug>(easymotion-bd-fl)','<Plug>(easymotion-bd-tl)','<Plug>(easymotion-j)','<Plug>(easymotion-s2)','<Plug>(easymotion-sn)',
\                   '<Plug>(easymotion-k)','<Plug>(easymotion-bd-jk)','<Plug>(easymotion-lineanywhere)','<Plug>(easymotion-bd-w)']
\   }
\}

NeoBundle 'kana/vim-operator-user'
NeoBundle 'kana/vim-textobj-user'

NeoBundleLazy 'kana/vim-textobj-line',{
\   'autoload':{
\       'mappings':['<Plug>(textobj-line-a)','<Plug>(textobj-line-i)']
\   }
\}

NeoBundleLazy 'bps/vim-textobj-python',{
\   'autoload':{
\       'filetypes':['python']
\   } 
\}

NeoBundleLazy 'rhysd/vim-operator-surround',{
\   'autoload':{
\       'mappings':['<Plug>(operator-surround-append)','<Plug>(operator-surround-delete)','<Plug>(operator-surround-replace)']
\   }
\}

NeoBundleLazy 'kana/vim-operator-replace',{
\   'autoload':{
\       'mappings':['<Plug>(operator-replace)']
\   }
\}

NeoBundleLazy 'mattn/emmet-vim',{
\   'autoload':{
\       'filetypes':['html','css','php']
\   }
\}

NeoBundleLazy 'vim-scripts/camelcasemotion',{
\   'autoload':{
\       'mappings':['<Plug>CamelCaseMotion_w','<Plug>CamelCaseMotion_b','<Plug>CamelCaseMotion_e']
\   }
\}

NeoBundleLazy 'haya14busa/incsearch.vim',{
\   'autoload':{
\       'mappings':['<Plug>(incsearch-forward)','<Plug>(incsearch-nohl-n)','<Plug>(incsearch-nohl-N)'],
\       'function_prefix':['incsearch'],
\   }
\}

NeoBundleLazy 'osyo-manga/vim-anzu',{
\   'autoload':{
\       'mappings':['<Plug>(anzu-n-with-echo)']
\   }
\}

NeoBundle 'thinca/vim-zenspace'
NeoBundle 'tpope/vim-fugitive'

NeoBundleLazy 'tyru/restart.vim',{
\   'autoload':{
\       'commands':["Restart"]
\   }
\}

NeoBundleLazy 'soramugi/auto-ctags.vim',{
\   'autoload':{
\       'commands':['Ctags']
\   }
\}

NeoBundleLazy 'sgur/vim-py3diff',{
\   'autoload':{
\       'commands':['Diff']
\   }
\}

NeoBundleLazy 'haya14busa/incsearch-easymotion.vim',{
\   'depends':['incsearch.vim','vim-easymotion'],
\   'autoload':{
\       'mappings':['<Plug>(incsearch-easymotion-/)'],
\       'function_prefix':['incsearch'],
\   }
\}

NeoBundleLazy 'tyru/open-browser.vim',{
\   'autoload':{
\       'mappings':['tyru/open-browser.vim'],
\       'commands':['OpenBrowserSearch','OpenBrowser','OpenBrowserCurrent']
\   }
\}

NeoBundleLazy 'stephpy/vim-php-cs-fixer',{
\   'autoload':{
\       'filetypes':['php']
\   }
\}

" NeoBundle 'tpope/vim-dispatch'
" NeoBundle 'scrooloose/nerdtree'
" NeoBundle 'kana/vim-textobj-indent'
" NeoBundle 'haya14busa/vim-migemo'
" NeoBundle 'haya14busa/incsearch-migemo.vim'

NeoBundle 'lambdalisue/vim-gita'

call neobundle#end()
NeoBundleCheck
