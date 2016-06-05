" :Restart 時に変数の定義を行う

nnoremap <C-S-F4> :<C-u>Restart<CR>

let s:bundle=neobundle#get('restart.vim')
function! s:bundle.hooks.on_source(bundle)
	" 終了時に保存するセッションオプションを設定する
	let g:restart_sessionoptions = 'curdir,help,tabpages'
endfunction
unlet s:bundle
