
set tabline=%!MakeTabLine()

function! MakeTabLine() "{{{
  let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
  let sep = ''  " タブ間の区切り
  let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'
  " let info = ''  " 好きな情報を入れる

  "FoldCCnavi
  " if exists('*FoldCCnavi')
  "   let info .= '%#TabLineInfo#'.substitute(FoldCCnavi()[-60:],'\s>\s','%#TabLineFill#> %#TabLineInfo#','g').'%0* '
  " endif

  " if exists('g:cwd_map')
	 "  let current_directory = s:cwd_mapping(g:cwd_map)
  " else
	 "  let current_directory = getcwd()
  " endif
  "カレントディレクトリ
  " let info .= '['.fnamemodify(current_directory, ":~") . ']'
  " echomsg string(split(getcwd(),'\\'))

  " return tabpages . '%=' . info  " タブリストを左に、情報を右に表示
  return tabpages
endfunction "}}}

" function! s:cwd_mapping(mappings) abort
" 	let directory_names=[]
" 	for directory_name in split(getcwd(),'\\')
" 		if has_key(a:mappings,directory_name)
" 			call add(directory_names,a:mappings[directory_name])
" 			continue
" 		endif
" 		call add(directory_names,directory_name)
" 	endfor
" 	return join(directory_names,'\')
" endfunction

function! s:tabpage_label(tabpagenr) "{{{
  "rol;各タブページのカレントバッファ名+αを表示
  let title = gettabvar(a:tabpagenr, 'title') "タブローカル変数t:titleを取得
  if title !=# ''
    return title
  endif

  " タブページ内のバッファのリスト
  let bufnrs = tabpagebuflist(a:tabpagenr)

  " カレントタブページかどうかでハイライトを切り替える
  let hi = a:tabpagenr is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'

  " バッファが複数あったらバッファ数を表示
  let no = len(bufnrs)
  if no is 1
    let no = ''
  endif
  " タブページ内に変更ありのバッファがあったら '+' を付ける
  let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '+' : ''
  let nomod = (no . mod) ==# '' ? '' : '['.no.mod.']'

  " カレントバッファ
  let curbufnr = bufnrs[tabpagewinnr(a:tabpagenr) - 1]  " tabpagewinnr() は 1 origin
  let fname = fnamemodify(bufname(curbufnr), ':t')
  let fname = fname is '' ? 'No title' : fname "バッファが空ならNo title

  let label = fname . nomod

  " return '%' . a:tabpagenr . 'T' . hi .a:tabpagenr.': '. curbufnr.'-' . label . '%T%#TabLineFill#'
  " return '%' . a:tabpagenr . 'T' . hi .a:tabpagenr.': '.label .' '. '%T%#TabLineFill#'
  return '%' . a:tabpagenr . 'T' . hi .' '.label .' '. '%T%#TabLineFill#'
endfunction "}}}
