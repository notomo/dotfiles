
set tabline=%!MakeTabLine()

function! MakeTabLine() "{{{
  let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
  let sep = ''  " �^�u�Ԃ̋�؂�
  let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'
  let info = ''  " �D���ȏ�������

  "FoldCCnavi
  if exists('*FoldCCnavi')
    let info .= '%#TabLineInfo#'.substitute(FoldCCnavi()[-60:],'\s>\s','%#TabLineFill#> %#TabLineInfo#','g').'%0* '
  endif

  "�J�����g�f�B���N�g��
  let info .= '['.fnamemodify(getcwd(), ":~") . ']'

  return tabpages . '%=' . info  " �^�u���X�g�����ɁA�����E�ɕ\��
endfunction "}}}


function! s:tabpage_label(tabpagenr) "{{{
  "rol;�e�^�u�y�[�W�̃J�����g�o�b�t�@��+����\��
  let title = gettabvar(a:tabpagenr, 'title') "�^�u���[�J���ϐ�t:title���擾
  if title !=# ''
    return title
  endif

  " �^�u�y�[�W���̃o�b�t�@�̃��X�g
  let bufnrs = tabpagebuflist(a:tabpagenr)

  " �J�����g�^�u�y�[�W���ǂ����Ńn�C���C�g��؂�ւ���
  let hi = a:tabpagenr is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'

  " �o�b�t�@��������������o�b�t�@����\��
  let no = len(bufnrs)
  if no is 1
    let no = ''
  endif
  " �^�u�y�[�W���ɕύX����̃o�b�t�@���������� '+' ��t����
  let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '+' : ''
  let nomod = (no . mod) ==# '' ? '' : '['.no.mod.']'

  " �J�����g�o�b�t�@
  let curbufnr = bufnrs[tabpagewinnr(a:tabpagenr) - 1]  " tabpagewinnr() �� 1 origin
  let fname = fnamemodify(bufname(curbufnr), ':t')
  let fname = fname is '' ? 'No title' : fname "�o�b�t�@����Ȃ�No title

  let label = fname . nomod

  " return '%' . a:tabpagenr . 'T' . hi .a:tabpagenr.': '. curbufnr.'-' . label . '%T%#TabLineFill#'
  " return '%' . a:tabpagenr . 'T' . hi .a:tabpagenr.': '.label .' '. '%T%#TabLineFill#'
  return '%' . a:tabpagenr . 'T' . hi .' '.label .' '. '%T%#TabLineFill#'
endfunction "}}}
