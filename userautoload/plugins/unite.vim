
"unite prefix key.
nnoremap [unite] <Nop>
nmap <Space>u [unite]

"unite general settings
call unite#custom_default_action('file', 'tabopen')

"インサートモードで開始
let g:unite_enable_start_insert = 1

"最近開いたファイル履歴の保存数
let g:unite_source_file_mru_limit = 50

"file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
let g:unite_source_file_mru_filename_format = ''

"現在開いているファイルのディレクトリ下のファイル一覧。
"開いていない場合はカレントディレクトリ
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
"クラス・関数（アウトライン）一覧
nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
"レジスタ一覧
nnoremap <silent> [unite]c :<C-u>Unite -buffer-name=register register<CR>
"最近使用したファイル一覧
nnoremap <silent> [unite]r :<C-u>Unite file_mru<CR>
"マーク一覧
nnoremap <silent> [unite]m :<C-u>Unite mark<CR>
"ブックマーク一覧
nnoremap <silent> [unite]s :<C-u>Unite bookmark<CR>
"ブックマークに追加
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>

"uniteを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
	"ESCでuniteを終了
	nmap <buffer> <ESC> <Plug>(unite_exit)
	imap <buffer> jq <Plug>(unite_exit)
	"入力モードのときjjでノーマルモードに移動
	imap <buffer> jj <Plug>(unite_insert_leave)
	"入力モードのときctrl+wでバックスラッシュも削除
	imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
	"ctrl+hで縦に分割して開く
	nnoremap <silent> <buffer> <expr> <C-h> unite#do_action('split')
	inoremap <silent> <buffer> <expr> <C-h> unite#do_action('split')
	"ctrl+vで横に分割して開く
	nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
	inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
	"ctrl+oでその場所に開く
	nnoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
	inoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
    inoremap <buffer> <C-b> <BS>
    inoremap <buffer> <C-d> <Del>
    inoremap <buffer> <C-h> <Left>
    inoremap <buffer> <C-l> <Right>
endfunction"}}}

