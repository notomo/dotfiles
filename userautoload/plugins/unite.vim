
"unite prefix key.
nnoremap [unite] <Nop>
nmap <Space>u [unite]

let s:bundle=neobundle#get('unite.vim')
function! s:bundle.hooks.on_source(bundle)
    "unite general settings
    call unite#custom_default_action('file', 'tabopen')

    "�C���T�[�g���[�h�ŊJ�n
    let g:unite_enable_start_insert = 1

    "�ŋߊJ�����t�@�C�������̕ۑ���
    let g:unite_source_file_mru_limit = 200

    "file_mru�̕\���t�H�[�}�b�g���w��B��ɂ���ƕ\���X�s�[�h�������������
    let g:unite_source_file_mru_filename_format = ''
endfunction
unlet s:bundle

"���݊J���Ă���t�@�C���̃f�B���N�g�����̃t�@�C���ꗗ�B
"�J���Ă��Ȃ��ꍇ�̓J�����g�f�B���N�g��
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -no-split -buffer-name=files file<CR>
"�o�b�t�@�ꗗ
nnoremap <silent> [unite]b :<C-u>Unite -no-split buffer<CR>
"�N���X�E�֐��i�A�E�g���C���j�ꗗ
nnoremap <silent> [unite]o :<C-u>Unite -no-split outline<CR>
"���W�X�^�ꗗ
nnoremap <silent> [unite]c :<C-u>Unite -no-split -buffer-name=register register<CR>
"�ŋߎg�p�����t�@�C���ꗗ
nnoremap <silent> [unite]r :<C-u>Unite -no-split file_mru<CR>
"�}�[�N�ꗗ
nnoremap <silent> [unite]m :<C-u>Unite -no-split mark<CR>
"�u�b�N�}�[�N�ꗗ
nnoremap <silent> [unite]s :<C-u>Unite -no-split bookmark<CR>
"�u�b�N�}�[�N�ɒǉ�
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>


nnoremap <silent> [unite]gb :<C-u>Unite giti/branch<CR>
nnoremap <silent> [unite]gB :<C-u>Unite giti/branch_all<CR>
nnoremap <silent> [unite]gc :<C-u>Unite giti/config<CR>
nnoremap <silent> [unite]gl :<C-u>Unite giti/log<CR>
nnoremap <silent> [unite]gs :<C-u>Unite giti/status<CR>


"unite���J���Ă���Ԃ̃L�[�}�b�s���O
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
	imap <buffer> jq <Plug>(unite_exit)
	"���̓��[�h�̂Ƃ�jj�Ńm�[�}�����[�h�Ɉړ�
	imap <buffer> jj <Plug>(unite_insert_leave)
	"ctrl+h�ŏc�ɕ������ĊJ��
	nnoremap <silent> <buffer> <expr> <C-h> unite#do_action('split')
	inoremap <silent> <buffer> <expr> <C-h> unite#do_action('split')
	"ctrl+v�ŉ��ɕ������ĊJ��
	nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
	inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
	"ctrl+o�ł��̏ꏊ�ɊJ��
	nnoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
	inoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
	"ctrl+t�Ń^�u�ŊJ��
	nnoremap <silent> <buffer> <expr> <C-t> unite#do_action('tabopen')
	inoremap <silent> <buffer> <expr> <C-t> unite#do_action('tabopen')

	nnoremap <silent> <buffer> <expr> v unite#do_action('persist_open')

    inoremap <buffer> <C-b> <BS>
    inoremap <buffer> <C-d> <Del>
    inoremap <buffer> <C-h> <Left>
    inoremap <buffer> <C-l> <Right>
endfunction"}}}

