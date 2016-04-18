"----------------------------------------------
" vim�̃}�[�N�@�\���ł��邾�����p���Ă݂� - Make �L noise
" http://saihoooooooo.hatenablog.com/entry/2013/04/30/001908
" m���������ƂŌ��݈ʒu�ɑ΂��Ď����I�ɃA���t�@�x�b�g������U��
"----------------------------------------------

" ��{�}�b�v
nnoremap [mark] <Nop>
nmap m [mark]

" ���݈ʒu���}�[�N
if !exists('g:markrement_char')
    let g:markrement_char = [
    \     'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
    \     'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    \ ]
endif
nnoremap <silent>[mark]m :<C-u>call <SID>AutoMarkrement()<CR>
function! s:AutoMarkrement()
    if !exists('b:markrement_pos')
        let b:markrement_pos = 0
    else
        let b:markrement_pos = (b:markrement_pos + 1) % len(g:markrement_char)
    endif
    execute 'mark' g:markrement_char[b:markrement_pos]
    echo 'marked' g:markrement_char[b:markrement_pos]
endfunction

" ���Ƀ}�[�N���镶����ݒ肷��Ex�R�}���h���`
command! -nargs=? SetNextMarkChar call s:set_next_mark_char(<f-args>)
function! s:set_next_mark_char(...)
  if a:0 >= 1
    let b:markrement_pos=index(g:markrement_char,a:1)-1
  else
    echo "Next:".g:markrement_char[b:markrement_pos+1]
  end
endfunction

" ���Ƀ}�[�N���镶����ݒ肵�āC�����Ƀ}�[�N����
nnoremap [mark]sa :SetNextMarkChar a<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]sb :SetNextMarkChar b<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]sc :SetNextMarkChar c<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]sd :SetNextMarkChar d<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]se :SetNextMarkChar e<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]sf :SetNextMarkChar f<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]sg :SetNextMarkChar g<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]sh :SetNextMarkChar h<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]si :SetNextMarkChar i<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]sj :SetNextMarkChar j<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]sk :SetNextMarkChar k<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]sl :SetNextMarkChar l<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]sm :SetNextMarkChar m<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]sn :SetNextMarkChar n<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]so :SetNextMarkChar o<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]sp :SetNextMarkChar p<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]sq :SetNextMarkChar q<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]sr :SetNextMarkChar r<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]ss :SetNextMarkChar s<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]st :SetNextMarkChar t<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]su :SetNextMarkChar u<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]sv :SetNextMarkChar v<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]sw :SetNextMarkChar w<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]sx :SetNextMarkChar x<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]sy :SetNextMarkChar y<CR>:<C-u>call <SID>AutoMarkrement()<CR>
nnoremap [mark]sz :SetNextMarkChar z<CR>:<C-u>call <SID>AutoMarkrement()<CR>

" ��/�O�̃}�[�N
nnoremap [mark]n ]`
nnoremap [mark]p [`

" �}�[�N�̑S�폜
nnoremap [mark]d :<C-u>delmark!<CR>

"�}�[�N�ւ̃W�����v
nnoremap [mark]j '
