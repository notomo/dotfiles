"�E�B���h�E�ړ�
let s:WINMOVE_PREFIX_KEY = "m"
nnoremap [winmove] <Nop>
silent execute join(["nmap", s:WINMOVE_PREFIX_KEY, "[winmove]"])

" ��
nnoremap [winmove]a <C-w>h
" ��
nnoremap [winmove]j <C-w>j
nnoremap [winmove]x <C-w>j
" ��
nnoremap [winmove]k <C-w>k
nnoremap [winmove]w <C-w>k
" �E
nnoremap [winmove]l <C-w>l
" ��
nnoremap [winmove]n <C-w><C-w>
" �O
nnoremap [winmove]p <C-w>p


"�E�B���h�E�����E����
nnoremap [window] <Nop>
nmap <Space>s [window]

" ������
nnoremap [window]h :<C-u>split<CR>
" �c����
nnoremap [window]v :<C-u>vsplit<CR>
" ��������
nnoremap [window]o :<C-u>only<CR>
" �v���r���[�E�B���h�E�����
nnoremap [window]p <C-w>z


" �E�B���h�E�T�C�Y�ύX
let s:WINSIZE_PREFIX_KEY = s:WINMOVE_PREFIX_KEY . "m"
nnoremap [winsize] <Nop>
silent execute join(["nmap", s:WINSIZE_PREFIX_KEY, "[winsize]"])

" �E�B���h�E�T�C�Y�ύX���[�h�ݒ�
" [winsize]lhs_suffix�Ń��[�h�ɓ���
" ���[�h���ł�lhs_suffix�݂̂œ���
function! s:winsize_submode_mapping(lhs_suffix, rhs) abort
    call submode#enter_with('winsize', 'n', '', s:WINSIZE_PREFIX_KEY . a:lhs_suffix, a:rhs)
    call submode#map('winsize', 'n', '', a:lhs_suffix, a:rhs)
endfunction
" �����𑝂₷
call s:winsize_submode_mapping("a", "<C-w>>")
" ���������炷
call s:winsize_submode_mapping("z", "<C-w><")
" �c���𑝂₷
call s:winsize_submode_mapping("k", "<C-w>+")
" �c�������炷
call s:winsize_submode_mapping("j", "<C-w>-")

" �ϓ���
nnoremap [winsize]e  <C-w>=
" �ő剻
nnoremap [winsize]m :<C-u>SM 4<CR>
" �ő剻������
nnoremap [winsize]r :<C-u>SM 0<CR>

