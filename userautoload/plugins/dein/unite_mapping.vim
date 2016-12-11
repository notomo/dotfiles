"unite prefix key.
nnoremap [unite] <Nop>
nmap <Space>u [unite]

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
nnoremap <silent> [unite]ma :<C-u>Unite -no-split mark<CR>
" ブックマーク一覧
nnoremap <silent> [unite]p :<C-u>Unite -no-split bookmark<CR>
"ブックマークに追加
nnoremap <silent> [unite]<Space> :<C-u>UniteBookmarkAdd<CR><CR><CR>

nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>

nnoremap <silent> [unite]ls :<C-u>Unite -no-split blocklines<CR>
nnoremap <silent> [unite]lb :<C-u>Unite -no-split block<CR>

nnoremap <silent> [unite]ll :<C-u>Unite -no-split line<CR>

" nnoremap <silent> [unite]j :<C-u>Unite -no-split jump<CR>

nnoremap <silent> [unite]j :<C-u>Unite -no-split jump<CR>
nnoremap <silent> [unite]ta :<C-u>Unite -no-split tab<CR>
nnoremap <silent> [unite]ti :<C-u>Unite redmine<CR>

nnoremap <silent> [unite]sf :<C-u>Unite -no-split file_rec<CR>
nnoremap <silent> [unite]sg :<C-u>Unite -no-split file_rec/git<CR>

nnoremap <silent> [unite]sv :<C-u>UniteSessionSave<CR>
nnoremap <silent> [unite]sl :<C-u>UniteSessionLoad<CR>
nnoremap <silent> [unite]ss :<C-u>Unite -no-split session<CR>

nnoremap <silent> [unite]w :<C-u>Unite -no-split webcolorname<CR>

nnoremap <silent> [unite]h :<C-u>Unite -tab -no-split help<CR>

" nnoremap <silent> [unite]k :<C-u>Unite -no-split output:map|map!|lmap<CR>


nnoremap <silent> [unite]gb :<C-u>Unite -no-split giti/branch<CR>
nnoremap <silent> [unite]gB :<C-u>Unite -no-split giti/branch_all<CR>
nnoremap <silent> [unite]gc :<C-u>Unite -no-split giti/config<CR>
" nnoremap <silent> [unite]gl :<C-u>Unite -no-split giti/log<CR>
nnoremap <silent> [unite]gs :<C-u>Unite -no-split giti/status<CR>

nnoremap <silent> [unite]mp :<C-u>Unite -no-split mapping<CR>

nnoremap <silent> [unite]gg  :<C-u>Unite -tab -no-split -no-quit grep:. -buffer-name=GREP<CR>
" nnoremap <silent> [unite]gg  :<C-u>Unite -no-split grep/git:.<CR>
" nnoremap <silent> [unite]q :<C-u>U-no-split giti/status<CR>nite -tab -no-split qf:ex=grep\ ""\ *<Left><Left><Left><Left>
" function! GlogFix() abort
"     execute ":normal Glog \| copen"
" endfunction
" command! GlogFixCommand call GlogFix()

" nnoremap <silent> [unite]gl :<C-u>Unite -tab -no-split qf:ex=Glog<CR>
" nnoremap <silent> [unite]q :<C-u>Unite qf -tab -no-split -no-quit<CR>

nnoremap <silent> [unite]v :<C-u>Unite variable -no-split -no-quit<CR>
