
cd %HOMEPATH%
mklink ".vimrc" %HOMEPATH%"\dotfiles\vim\rc\.vimrc"
mklink ".gvimrc" %HOMEPATH%"\dotfiles\vim\rc\.gvimrc"
mklink ".vimrc_first.vim" %HOMEPATH%"\dotfiles\vim\rc\kaoriya\.vimrc_first.vim"
mklink ".gvimrc_first.vim" %HOMEPATH%"\dotfiles\vim\rc\kaoriya\.gvimrc_first.vim"

mkdir %HOMEPATH%"\.vim" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mklink /D %HOMEPATH%"\.vim\rc" %HOMEPATH%"\dotfiles\vim\rc"
mklink /D %HOMEPATH%"\.vim\autoload" %HOMEPATH%"\dotfiles\vim\autoload"
mklink /D %HOMEPATH%"\.vim\dict" %HOMEPATH%"\dotfiles\vim\dict"
mklink /D %HOMEPATH%"\.vim\snippets" %HOMEPATH%"\dotfiles\vim\snippets"
mklink /D %HOMEPATH%"\.vim\tmp" %HOMEPATH%"\dotfiles\vim\tmp"
mklink /D %HOMEPATH%"\.vim\after" %HOMEPATH%"\dotfiles\vim\after"
mklink /D %HOMEPATH%"\.vim\ftplugin" %HOMEPATH%"\dotfiles\vim\ftplugin"
mklink /D %HOMEPATH%"\.vim\syntax" %HOMEPATH%"\dotfiles\vim\syntax"
mklink /D %HOMEPATH%"\.vim\indent" %HOMEPATH%"\dotfiles\vim\indent"
mklink /D %HOMEPATH%"\.vim\rplugin" %HOMEPATH%"\dotfiles\vim\rplugin"

mkdir %HOMEPATH%"\.config" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mklink /D %HOMEPATH%"\.config\nvim" "\.vim"
cd %HOMEPATH%"\.config\nvim"
mklink "init.vim" %HOMEPATH%"\dotfiles\vim\rc\init.vim"
mklink "ginit.vim" %HOMEPATH%"\dotfiles\vim\rc\ginit.vim"

mkdir %USERPROFILE%"\AppData\Local\nvim" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mklink "init.vim" %HOMEPATH%"\dotfiles\vim\rc\init.vim"
mklink "ginit.vim" %HOMEPATH%"\dotfiles\vim\rc\ginit.vim"

cd %HOMEPATH%
mklink ".ideavimrc" %HOMEPATH%"\dotfiles\idea\.ideavimrc"

mklink ".flake8" %HOMEPATH%"\dotfiles\lint\python\.flake8"
mklink ".vintrc.yaml" %HOMEPATH%"\dotfiles\lint\vim\.vintrc.yaml"

pause
