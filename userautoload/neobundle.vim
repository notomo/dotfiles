
if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim
    set runtimepath+=~/.vim/
    set runtimepath+=~/.vim/after/
    set runtimepath+=~/.vim/after/plugin/*
    set runtimepath+=~/.vim/after/syntax/*
    " set runtimepath+=~/.vim/plugin/sample.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundleLazy 'Yggdroot/indentLine',{
\   'autoload':{
\       'filetypes':['python']
\   }
\}

NeoBundleLazy 'Shougo/neocomplete.vim',{
\   'on_i' : 1
\}

NeoBundle 'Shougo/neoinclude.vim'

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
\       'filetypes':['php', 'python']
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
\       'commands':['VimShell']
\   }
\}

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'make -f make_mingw32.mak',
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
\       'commands':['Unite']
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

NeoBundleLazy 'unite-blocklines',{
\   'autoload':{
\       'on_source': 'unite.vim'
\   }
\}

NeoBundleLazy 'unite-block',{
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
\       'commands' : ['UniteSessionSave', 'UniteSessionLoad']
\   }
\}

NeoBundleLazy 'scrooloose/syntastic',{
\   'autoload':{
\       'filetypes':['python', 'php']
\   }
\}

NeoBundleLazy 'Shougo/vimfiler.vim',{
\   'autoload':{
\       'commands':['VimFilerBufferDir']
\   }
\}

NeoBundleLazy 'LeafCage/qutefinger.vim',{
\   'autoload':{
\       'mappings':['<Plug>(qutefinger-']
\   }
\}

NeoBundleLazy 'Lokaltog/vim-easymotion',{
\   'autoload':{
\       'mappings':['<Plug>(easymotion-']
\   }
\}

NeoBundle 'kana/vim-operator-user'
NeoBundle 'kana/vim-textobj-user'

NeoBundleLazy 'kana/vim-textobj-line',{
\   'autoload':{
\       'mappings':['<Plug>(textobj-line-']
\   }
\}

NeoBundleLazy 'bps/vim-textobj-python',{
\   'autoload':{
\       'filetypes':['python']
\   }
\}

NeoBundleLazy 'rhysd/vim-operator-surround',{
\   'autoload':{
\       'mappings':['<Plug>(operator-surround-']
\   }
\}

NeoBundleLazy 'mattn/emmet-vim',{
\   'autoload':{
\       'filetypes':['html', 'css', 'php']
\   }
\}

NeoBundleLazy 'vim-scripts/camelcasemotion',{
\   'autoload':{
\       'mappings':['<Plug>CamelCaseMotion_']
\   }
\}

NeoBundleLazy 'haya14busa/incsearch.vim',{
\   'autoload':{
\       'mappings':['<Plug>(incsearch-forward)', '<Plug>(incsearch-nohl-n)', '<Plug>(incsearch-nohl-N)'],
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
\   'depends':['incsearch.vim', 'vim-easymotion'],
\   'autoload':{
\       'mappings':['<Plug>(incsearch-easymotion-'],
\       'function_prefix':['incsearch'],
\   }
\}

NeoBundleLazy 'tyru/open-browser.vim',{
\   'autoload':{
\       'mappings':['<Plug>(openbrowser-'],
\       'commands':['OpenBrowser']
\   }
\}

NeoBundleLazy 'stephpy/vim-php-cs-fixer',{
\   'autoload':{
\       'filetypes':['php']
\   }
\}

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
\       'filetypes':['javascript', 'css', 'html', 'vim'],
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


NeoBundle 'thinca/vim-singleton'


NeoBundle 'vim-jp/vital.vim'


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

NeoBundleLazy 'thinca/vim-tabrecent',{
\   'autoload':{
\       'commands':['TabRecent']
\   }
\}

NeoBundleLazy 'OmniSharp/omnisharp-vim', {
\   'autoload': {'filetypes': ['cs']},
\ }

" NeoBundle 'tpope/vim-dispatch'

NeoBundleLazy 'OrangeT/vim-csharp',{
\   'autoload':{
\       'filetypes':['cs']
\   }
\}

NeoBundle 'kana/vim-arpeggio'

NeoBundle 'tpope/vim-capslock'

NeoBundle 'vim-scripts/PreserveNoEOL'

NeoBundle 'LeafCage/yankround.vim'

NeoBundleLazy 'Shougo/neoyank.vim',{
\   'autoload':{
\       'on_source': 'unite.vim'
\   }
\}

NeoBundleLazy 'sjl/gundo.vim',{
\   'autoload':{
\       'commands':['GundoToggle']
\   }
\}

NeoBundle 'kana/vim-submode'

NeoBundleLazy 'osyo-manga/vim-textobj-multiblock',{
\   'autoload':{
\       'mappings':['<Plug>(textobj-multiblock-']
\   }
\}

NeoBundleLazy 'thinca/vim-operator-sequence'

NeoBundleLazy 't9md/vim-quickhl',{
\   'autoload':{
\       'mappings':['<Plug>(quickhl-manual-']
\   }
\}

NeoBundleLazy 'osyo-manga/vim-textobj-from_regexp'

NeoBundleLazy 'osyo-manga/vim-textobj-blockwise'

" NeoBundle 'LeafCage/foldCC.vim'

NeoBundleLazy 'kana/vim-operator-replace',{
\   'autoload':{
\       'mappings':['<Plug>(operator-replace)']
\   }
\}

NeoBundle 'itchyny/vim-parenmatch'
NeoBundle 'itchyny/vim-cursorword'

" NeoBundle 'osyo-manga/vim-over'

" NeoBundle 'LeafCage/visiblemarks.vim'
" NeoBundle 'kshenoy/vim-signature'

" NeoBundleLazy "osyo-manga/vim-operator-exec_command"

" NeoBundle 'yuratomo/gmail.vim'
" NeoBundle 'vim-scripts/pdbvim'
" NeoBundle 'fuenor/qfixgrep'
" NeoBundle 'mattn/vim-oauth'
" NeoBundle 'mattn/vim-metarw'
" NeoBundle 'mattn/vim-metarw-redmine'
" NeoBundle 'scrooloose/nerdtree'
" NeoBundle 'kana/vim-textobj-indent'
" NeoBundle 'haya14busa/vim-migemo'
" NeoBundle 'haya14busa/incsearch-migemo.vim'
" NeoBundle 'tmhedberg/matchit'
" NeoBundle 'ctrlpvim/ctrlp.vim'
" NeoBundle 'mattn/webapi-vim'
" NeoBundleLazy 'osyo-manga/vim-operator-stay-cursor',{
" \   'autoload':{
" \       'mappings':['<Plug>(operator-stay-cursor-yank)']
" \   }
" \}
" NeoBundleLazy 'vim-scripts/dbext.vim',{
" \   'autoload':{
" \       'commands':['DB']
" \   }
" \}

call neobundle#end()
NeoBundleCheck
