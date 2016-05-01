
"unite prefix key.
nnoremap [unite] <Nop>
nmap <Space>u [unite]

"unite general settings
call unite#custom_default_action('file', 'tabopen')

"�C���T�[�g���[�h�ŊJ�n
let g:unite_enable_start_insert = 1

"�ŋߊJ�����t�@�C�������̕ۑ���
let g:unite_source_file_mru_limit = 50

"file_mru�̕\���t�H�[�}�b�g���w��B��ɂ���ƕ\���X�s�[�h�������������
let g:unite_source_file_mru_filename_format = ''

"���݊J���Ă���t�@�C���̃f�B���N�g�����̃t�@�C���ꗗ�B
"�J���Ă��Ȃ��ꍇ�̓J�����g�f�B���N�g��
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"�o�b�t�@�ꗗ
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
"�N���X�E�֐��i�A�E�g���C���j�ꗗ
nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
"���W�X�^�ꗗ
nnoremap <silent> [unite]c :<C-u>Unite -buffer-name=register register<CR>
"�ŋߎg�p�����t�@�C���ꗗ
nnoremap <silent> [unite]r :<C-u>Unite file_mru<CR>
"�}�[�N�ꗗ
nnoremap <silent> [unite]m :<C-u>Unite mark<CR>
"�u�b�N�}�[�N�ꗗ
nnoremap <silent> [unite]s :<C-u>Unite bookmark<CR>
"�u�b�N�}�[�N�ɒǉ�
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>

"unite���J���Ă���Ԃ̃L�[�}�b�s���O
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
	"ESC��unite���I��
	nmap <buffer> <ESC> <Plug>(unite_exit)
	imap <buffer> jq <Plug>(unite_exit)
	"���̓��[�h�̂Ƃ�jj�Ńm�[�}�����[�h�Ɉړ�
	imap <buffer> jj <Plug>(unite_insert_leave)
	"���̓��[�h�̂Ƃ�ctrl+w�Ńo�b�N�X���b�V�����폜
	imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
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
    inoremap <buffer> <C-b> <BS>
    inoremap <buffer> <C-d> <Del>
    inoremap <buffer> <C-h> <Left>
    inoremap <buffer> <C-l> <Right>
endfunction"}}}

