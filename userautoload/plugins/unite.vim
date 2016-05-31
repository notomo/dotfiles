
"unite prefix key.
nnoremap [unite] <Nop>
nmap <Space>u [unite]

let s:bundle=neobundle#get('unite.vim')
function! s:bundle.hooks.on_source(bundle)
    "unite general settings
    call unite#custom_default_action('file', 'tabopen')

    "インサートモードで開始
    let g:unite_enable_start_insert = 1

    "最近開いたファイル履歴の保存数
    let g:unite_source_file_mru_limit = 200

    "file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
    let g:unite_source_file_mru_filename_format = ''

    " let g:neomru#do_validate=0

    let g:unite_source_find_command = 'C:/Program Files/Git/usr/bin/find.exe'
    " let g:unite_source_find_command = 'C:/MinGW64/msys/1.0/bin/find.exe'

    " unite grepにjvgrepを使う
    " if executable('jvgrep')
    "     let g:unite_source_grep_command = 'jvgrep'
    "     let g:unite_source_grep_default_opts = '-r'
    "     let g:unite_source_grep_recursive_opt = '-R'
    " endif

endfunction
unlet s:bundle

"現在開いているファイルのディレクトリ下のファイル一覧。
"開いていない場合はカレントディレクトリ
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -no-split -buffer-name=files file<CR>
"バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite -no-split buffer<CR>
"クラス・関数（アウトライン）一覧
nnoremap <silent> [unite]o :<C-u>Unite -no-split outline<CR>
"レジスタ一覧
nnoremap <silent> [unite]c :<C-u>Unite -no-split -buffer-name=register register<CR>
"最近使用したファイル一覧
nnoremap <silent> [unite]r :<C-u>Unite -no-split file_mru<CR>
"マーク一覧
nnoremap <silent> [unite]m :<C-u>Unite -no-split mark<CR>
" ブックマーク一覧
" nnoremap <silent> [unite]s :<C-u>Unite -no-split bookmark<CR>
"ブックマークに追加
" nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>

nnoremap <silent> [unite]j :<C-u>Unite -no-split jump<CR>

nnoremap <silent> [unite]t :<C-u>Unite -no-split tab<CR>

nnoremap <silent> [unite]sf :<C-u>Unite -no-split file_rec/async<CR>
nnoremap <silent> [unite]sg :<C-u>Unite -no-split file_rec/git<CR>

nnoremap [unite]v :<C-u>UniteSessionSave<CR>
nnoremap <silent> [unite]l :<C-u>UniteSessionLoad<CR>
nnoremap <silent> [unite]S :<C-u>Unite -no-split session<CR>

nnoremap <silent> [unite]w :<C-u>Unite -no-split webcolorname<CR>

nnoremap <silent> [unite]h :<C-u>Unite -tab -no-split help<CR>

" nnoremap <silent> [unite]k :<C-u>Unite -no-split output:map|map!|lmap<CR>


nnoremap <silent> [unite]gb :<C-u>Unite -no-split giti/branch<CR>
nnoremap <silent> [unite]gB :<C-u>Unite -no-split giti/branch_all<CR>
nnoremap <silent> [unite]gc :<C-u>Unite -no-split giti/config<CR>
nnoremap <silent> [unite]gl :<C-u>Unite -no-split giti/log<CR>
nnoremap <silent> [unite]gs :<C-u>Unite -no-split giti/status<CR>

nnoremap <silent> [unite]G  :<C-u>Unite -no-split grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> [unite]gg  :<C-u>Unite -no-split grep/git:.<CR>

"uniteを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
	imap <buffer> jq <Plug>(unite_exit)
	"入力モードのときjjでノーマルモードに移動
	imap <buffer> jj <Plug>(unite_insert_leave)
	"ctrl+hで縦に分割して開く
	nnoremap <silent> <buffer> <expr> <C-h> unite#do_action('split')
	inoremap <silent> <buffer> <expr> <C-h> unite#do_action('split')
	"ctrl+vで横に分割して開く
	nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
	inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
	"ctrl+oでその場所に開く
	nnoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
	nnoremap <silent> <buffer> <expr> o unite#do_action('open')
	inoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
	"ctrl+tでタブで開く
	nnoremap <silent> <buffer> <expr> <C-t> unite#do_action('tabopen')
	inoremap <silent> <buffer> <expr> <C-t> unite#do_action('tabopen')

	nnoremap <silent> <buffer> <expr> v unite#do_action('persist_open')

    nnoremap <silent> <buffer> <expr> ga unite#do_action('add') 
    nnoremap <silent> <buffer> <expr> gu unite#do_action('unstage') 
    nnoremap <silent> <buffer> <expr> gi unite#do_action('ignore') 
    nnoremap <silent> <buffer> <expr> gm unite#do_action('merge') 
    nnoremap <silent> <buffer> <expr> gC unite#do_action('commit') 
    nnoremap <silent> <buffer> <expr> gs unite#do_action('switch') 
    nnoremap <silent> <buffer> <expr> gA unite#do_action('amend') 
    nnoremap <silent> <buffer> <expr> gR unite#do_action('revert') 

    nnoremap <silent> <buffer> <expr> yr unite#do_action('yank_rgb') 
    nnoremap <silent> <buffer> <expr> yh unite#do_action('yank_hex') 
    nnoremap <silent> <buffer> <expr> nr unite#do_action('insert_rgb') 
    nnoremap <silent> <buffer> <expr> nh unite#do_action('insert_hex') 

    inoremap <buffer> <C-b> <BS>
    inoremap <buffer> <C-d> <Del>
    inoremap <buffer> <C-h> <Left>
    inoremap <buffer> <C-l> <Right>

    nnoremap <buffer> b <C-^>
endfunction"}}}

