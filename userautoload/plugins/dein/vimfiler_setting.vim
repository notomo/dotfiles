
call vimfiler#custom#profile('default', 'context', {
\ 'safe' : 0,
\ 'simple' : 1,
\ 'no-quit' : 1,
\ })
let g:vimfiler_enable_auto_cd = 1
"vimデフォルトのエクスプローラをvimfilerで置き換える
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_ignore_pattern = ['^\.DS_Store$']
"デフォルトのキーマッピングを変更
let g:vimfiler_no_default_key_mappings = 1
