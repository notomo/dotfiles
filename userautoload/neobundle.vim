
" vim起動時のみruntimepathにneobundle.vimを追加
if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim
    set runtimepath+=~/.vim/
    set runtimepath+=~/.vim/after/
	set runtimepath+=~/.vim/after/plugin/
    " set runtimepath+=~/.vim/plugin/sample.vim/
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
\       'mappings':['<Plug>(ref-keyword)'],
\       'commands':['Ref']
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

NeoBundleLazy 'unite-redmine',{
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
\       'on_source': 'unite.vim'
\   }
\}

NeoBundleLazy 'tsukkee/unite-tag',{
\   'autoload':{
\       'on_source': 'unite.vim'
\   }
\}

NeoBundleLazy 'Shougo/unite-session',{
\   'autoload':{
\       'on_source': 'unite.vim',
\       'commands' : ['UniteSessionSave','UniteSessionLoad']
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
\                   '<Plug>(easymotion-k)','<Plug>(easymotion-bd-jk)','<Plug>(easymotion-lineanywhere)','<Plug>(easymotion-bd-w)','<Plug>(easymotion-tl)']
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

NeoBundleLazy 'sgur/vim-py3diff',{
\   'autoload':{
\       'commands':['Diff']
\   }
\}

NeoBundleLazy 'haya14busa/incsearch-easymotion.vim',{
\   'depends':['incsearch.vim','vim-easymotion'],
\   'autoload':{
\       'mappings':['<Plug>(incsearch-easymotion-/)','<Plug>(incsearch-easymotion-stay)','<Plug>(incsearch-easymotion-?)'],
\       'function_prefix':['incsearch'],
\   }
\}

NeoBundleLazy 'tyru/open-browser.vim',{
\   'autoload':{
\       'mappings':['<Plug>(openbrowser-smart-search)'],
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
" NeoBundle 'tmhedberg/matchit'
" NeoBundle 'ctrlpvim/ctrlp.vim'

NeoBundle 'lambdalisue/vim-gita'

NeoBundleLazy 'h1mesuke/vim-alignta',{
\   'autoload':{
\       'commands':['Alignta']
\   }
\}

NeoBundleLazy 'othree/yajs.vim',{
\   'autoload':{
\       'filetypes':['javascript']
\   }
\}

NeoBundleLazy 'lilydjwg/colorizer',{
\   'autoload':{
\       'filetypes':['javascript','css','html'],
\       'commands':['ColorToggle']
\   }
\}

NeoBundleLazy 'thinca/vim-fontzoom',{
\   'autoload':{
\       'commands':['Fontzoom']
\   }
\}

NeoBundleLazy 'thinca/vim-qfreplace',{
\   'autoload':{
\       'commands':['Qfreplace']
\   }
\}

NeoBundleLazy 'pasela/unite-webcolorname',{
\   'autoload':{
\       'on_source': 'unite.vim'
\   }
\}

NeoBundle 'Shougo/context_filetype.vim'


NeoBundleLazy 'Shougo/unite-help',{
\   'autoload':{
\       'on_source': 'unite.vim'
\   }
\}

NeoBundleLazy 'lambdalisue/unite-grep-vcs',{
\   'autoload':{
\       'on_source': 'unite.vim'
\   }
\}

" NeoBundle 'fuenor/qfixgrep'

NeoBundleLazy 'sgur/unite-qf',{
\   'autoload':{
\       'on_source': 'unite.vim'
\   }
\}

NeoBundleLazy 'mopp/layoutplugin.vim',{
\   'autoload':{
\       'commands':['LayoutPlugin']
\   }
\}

" NeoBundle 'yuratomo/gmail.vim'

NeoBundle 'mattn/webapi-vim'

NeoBundle 'thinca/vim-singleton'

" NeoBundle 'mattn/vim-metarw'
" NeoBundle 'mattn/vim-metarw-redmine'

NeoBundle 'vim-jp/vital.vim'

" NeoBundle 'mattn/vim-oauth'

NeoBundleLazy 'tyru/current-func-info.vim',{
\   'autoload':{
\       'function_prefix':['cfi']
\   }
\}

NeoBundleLazy 'tyru/operator-camelize.vim',{
\   'autoload':{
\       'mappings':['<Plug>(operator-camelize)', '<Plug>(operator-decamelize)', '<Plug>(operator-camelize-toggle)']
\   }
\}

NeoBundle 'vim-scripts/dbext.vim'

call neobundle#end()
NeoBundleCheck
