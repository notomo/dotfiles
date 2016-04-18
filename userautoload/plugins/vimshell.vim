
let g:vimshell_prompt_expr = 'getcwd()." > "'
let g:vimshell_prompt_pattern = '^\f\+ > '
let g:vimshell_user_prompt = 'getcwd()'

nnoremap [shell] <Nop>
vnoremap [shell] <Nop>
nmap <Leader>s [shell]
vmap <Leader>s [shell]

"�V�F�����N��
nnoremap <silent> [shell]r :<C-u>CdCurrent<CR>:VimShell<CR>
"�V�F����V�����N��
nnoremap <silent> [shell]c :<C-u>CdCurrent<CR>:VimShellCreate<CR>
"�V�F����V�����^�u�ŋN��
nnoremap <silent> [shell]t :<C-u>CdCurrent<CR>:VimShellTab<CR>
"���E�ɕ������ăV�F�����N��
nnoremap <silent> [shell]v :<C-u>vsplit<CR>:<C-w><C-W>:VimShell<CR>
"�㉺�ɕ������ăV�F�����N��
nnoremap <silent> [shell]h :<C-u>split<CR>:<C-w><C-w>:VimShell<CR>
"python��񓯊��ŋN��
nnoremap <silent> [shell]p :VimShellInteractive python<CR>
"�񓯊��ŊJ�����C���^�v���^�Ɍ��݂̍s��]��������
nnoremap <silent> [shell]s :VimShellSendString<CR>
"�񓯊��ŊJ�����C���^�v���^�ɑI���s��]��������
vnoremap <silent> [shell]s :VimShellSendString<CR>

"shell���J���Ă���Ԃ̃L�[�}�b�s���O
autocmd FileType vimshell call s:shell_my_settings()
function! s:shell_my_settings()"{{{
    nnoremap <buffer> <Space>uh G:<C-u>Unite vimshell/history<CR>
    nmap <buffer> <C-S-l> Gddih<Plug>(vimshell_enter)
    imap <buffer> <C-S-l> <ESC>Gddih<Plug>(vimshell_enter)
    inoremap <buffer> <C-w> <ESC>:<C-u>q<CR>
endfunction"}}}

