

"�E�B���h�E���ő剻���ċN��
au GUIEnter * simalt ~x
"���{����͂����Z�b�g
au BufNewFile,BufRead * set iminsert=0
" �u���{����͌Œ胂�[�h�v�̓��샂�[�h
let IM_CtrlMode = 4

let g:yankring_n_keys = 'Y D'
" default
" let g:yankring_n_keys = 'Y D x X'

set nowrap

set showtabline=2 " �^�u����ɕ\��
set guioptions-=e " gVim�ł��e�L�X�g�x�[�X�̃^�u�y�[�W���g��
" set incsearch  " �C���N�������^���T�[�`���s��
set ignorecase
set smartcase

if expand("%:t") !~ ".*\.tex"
    set autoindent
endif

set ruler
set number         " �s�ԍ���\������
set whichwrap=b,s,h,l,<,>,[,]  " �s���s���̍��E�ړ��ōs���܂���
set cursorline     " �J�[�\���s�̔w�i�F��ς���
set nolist
set laststatus=2   " �X�e�[�^�X�s����ɕ\��
set cmdheight=2    " ���b�Z�[�W�\������2�s�m��
set scrolloff=8                "�㉺8�s�̎��E���m��
set showmatch      " �Ή����銇�ʂ������\��
set wildmenu
set showcmd
set autoread   "�O���Ńt�@�C���ɕύX�����ꂽ�ꍇ�͓ǂ݂Ȃ���
set hidden     " �ۑ�����Ă��Ȃ��t�@�C��������Ƃ��ł��ʂ̃t�@�C�����J�����Ƃ��o����
set switchbuf=useopen   " �V�����J������ɂ��łɊJ���Ă���o�b�t�@���J��

" �Ή����ʂ�'<'��'>'�̃y�A��ǉ�
set matchpairs& matchpairs+=<:>
set shiftwidth=4
set softtabstop=4
set expandtab
set tabstop=4
set smarttab
set formatoptions=q
set clipboard=unnamed
" set autochdir
set grepprg=grep\ -rnIH 

set wrapscan
set nobackup
set noundofile
"�X���b�v�t�@�C���p�̃f�B���N�g��
set directory=$HOME/vimbackup
"�t�@�C���ۑ��_�C�A���O�̏����f�B���N�g�����o�b�t�@�t�@�C���ʒu�ɐݒ�
set browsedir=buffer 

let $PATH = $PATH . ';C:\MinGW64\bin;C:\MinGW64\msys\1.0\bin'
set statusline=%F%m%r%h%w\%=[COL=%c]\[FTYPE=%Y]\[ENC=%{&enc}]\[FENC=%{&fileencoding}]\[FORMAT=%{&ff}]
