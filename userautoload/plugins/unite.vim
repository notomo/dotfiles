
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
"ブックマーク一覧
nnoremap <silent> [unite]s :<C-u>Unite -no-split bookmark<CR>
"ブックマークに追加
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>


nnoremap <silent> [unite]gb :<C-u>Unite giti/branch<CR>
nnoremap <silent> [unite]gB :<C-u>Unite giti/branch_all<CR>
nnoremap <silent> [unite]gc :<C-u>Unite giti/config<CR>
nnoremap <silent> [unite]gl :<C-u>Unite giti/log<CR>
nnoremap <silent> [unite]gs :<C-u>Unite giti/status<CR>


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
	inoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
	"ctrl+tでタブで開く
	nnoremap <silent> <buffer> <expr> <C-t> unite#do_action('tabopen')
	inoremap <silent> <buffer> <expr> <C-t> unite#do_action('tabopen')

	nnoremap <silent> <buffer> <expr> v unite#do_action('persist_open')

    inoremap <buffer> <C-b> <BS>
    inoremap <buffer> <C-d> <Del>
    inoremap <buffer> <C-h> <Left>
    inoremap <buffer> <C-l> <Right>
endfunction"}}}

