
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.vim') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

execute 'set runtimepath+=' . s:dein_repo_dir

if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')

if !dein#load_state(s:dein_dir)
    finish
endif

call dein#begin(s:dein_dir)

let s:rc_dir    = expand('~/.vim/rc')
let s:toml      = s:rc_dir . '/dein.toml'
let s:lazy_toml = s:rc_dir . '/dein_lazy.toml'

call dein#load_toml(s:toml,      {'lazy': 0})
call dein#load_toml(s:lazy_toml, {'lazy': 1})

call dein#end()
call dein#save_state()

if dein#check_install()
    call dein#install()
endif
