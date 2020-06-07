
cd %HOMEPATH%
mklink ".vimrc" %HOMEPATH%"\dotfiles\vim\rc\.vimrc"
mklink ".gvimrc" %HOMEPATH%"\dotfiles\vim\rc\.gvimrc"
mklink ".vimrc_first.vim" %HOMEPATH%"\dotfiles\vim\rc\kaoriya\.vimrc_first.vim"
mklink ".gvimrc_first.vim" %HOMEPATH%"\dotfiles\vim\rc\kaoriya\.gvimrc_first.vim"

mkdir %HOMEPATH%"\.vim" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mklink /D %HOMEPATH%"\.vim\rc" %HOMEPATH%"\dotfiles\vim\rc"
mklink /D %HOMEPATH%"\.vim\autoload" %HOMEPATH%"\dotfiles\vim\autoload"
mklink /D %HOMEPATH%"\.vim\lua" %HOMEPATH%"\dotfiles\vim\lua"
mklink /D %HOMEPATH%"\.vim\dict" %HOMEPATH%"\dotfiles\vim\dict"
mklink /D %HOMEPATH%"\.vim\snippets" %HOMEPATH%"\dotfiles\vim\snippets"
mklink /D %HOMEPATH%"\.vim\after" %HOMEPATH%"\dotfiles\vim\after"
mklink /D %HOMEPATH%"\.vim\ftplugin" %HOMEPATH%"\dotfiles\vim\ftplugin"
mklink /D %HOMEPATH%"\.vim\syntax" %HOMEPATH%"\dotfiles\vim\syntax"
mklink /D %HOMEPATH%"\.vim\indent" %HOMEPATH%"\dotfiles\vim\indent"
mklink /D %HOMEPATH%"\.vim\rplugin" %HOMEPATH%"\dotfiles\vim\rplugin"
mklink /D %HOMEPATH%"\.vim\plugin" %HOMEPATH%"\dotfiles\vim\plugin"
mklink /D %HOMEPATH%"\.vim\ftdetect" %HOMEPATH%"\dotfiles\vim\ftdetect"
mklink /D %HOMEPATH%"\.vim\template" %HOMEPATH%"\dotfiles\vim\template"

mkdir %HOMEPATH%"\.vim\tmp" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mkdir %HOMEPATH%"\.vim\reference" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

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

mklink ".flake8" %HOMEPATH%"\dotfiles\lint\python\.flake8"
mklink ".vintrc.yaml" %HOMEPATH%"\dotfiles\lint\vim\.vintrc.yaml"

mklink ".gitignore_global" %HOMEPATH%"\dotfiles\git\.gitignore_global"

mkdir %HOMEPATH%"\app" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mkdir %HOMEPATH%"\.local" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mkdir %HOMEPATH%"\workspace" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mkdir %HOMEPATH%"\workspace\lsync" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

cd %HOMEPATH%"\.config"
copy %HOMEPATH%"\dotfiles\setup\windows\lemonade.toml" "lemonade.toml" /Y

pause
