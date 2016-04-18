
" vim‹N“®‚Ì‚İruntimepath‚Éneobundle.vim‚ğ’Ç‰Á
if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim
    set runtimepath+=~/.vim/
    "set runtimepath+=~/.vim/after
endif

" neobundle.vim‚Ì‰Šú‰» 
" NeoBundle‚ğXV‚·‚é‚½‚ß‚Ìİ’è
call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Yggdroot/indentLine'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'fuenor/im_control.vim'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'thinca/vim-ref'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tacroe/unite-mark'
NeoBundle 'Shougo/neomru.vim'

NeoBundle 'scrooloose/syntastic'
NeoBundle 'scrooloose/nerdtree'

NeoBundle 'LeafCage/qutefinger.vim'
NeoBundle "tyru/caw.vim.git"

NeoBundle 'Lokaltog/vim-easymotion'

NeoBundle 'Shougo/unite-outline'

NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'bps/vim-textobj-python'
NeoBundle 'kana/vim-textobj-underscore'
NeoBundle 'kana/vim-operator-user'
NeoBundle 'rhysd/vim-operator-surround'
NeoBundle 'kana/vim-textobj-line'
NeoBundle 'kana/vim-operator-replace'

NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'mattn/emmet-vim'

call neobundle#end()
NeoBundleCheck
