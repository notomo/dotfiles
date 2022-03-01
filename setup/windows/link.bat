
cd %HOMEPATH%

mkdir %HOMEPATH%"\.vim" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mklink /D %HOMEPATH%"\.vim\rc" %HOMEPATH%"\dotfiles\vim\rc"
mklink /D %HOMEPATH%"\.vim\lua" %HOMEPATH%"\dotfiles\vim\lua"
mklink /D %HOMEPATH%"\.vim\snippets" %HOMEPATH%"\dotfiles\vim\snippets"
mklink /D %HOMEPATH%"\.vim\after" %HOMEPATH%"\dotfiles\vim\after"
mklink /D %HOMEPATH%"\.vim\ftplugin" %HOMEPATH%"\dotfiles\vim\ftplugin"
mklink /D %HOMEPATH%"\.vim\syntax" %HOMEPATH%"\dotfiles\vim\syntax"
mklink /D %HOMEPATH%"\.vim\indent" %HOMEPATH%"\dotfiles\vim\indent"
mklink /D %HOMEPATH%"\.vim\ftdetect" %HOMEPATH%"\dotfiles\vim\ftdetect"

mkdir %HOMEPATH%"\.vim\tmp" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mkdir %HOMEPATH%"\.vim\reference" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mkdir %HOMEPATH%"\.config" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mklink /D %HOMEPATH%"\.config\nvim" "\.vim"
cd %HOMEPATH%"\.config\nvim"
mklink "init.lua" %HOMEPATH%"\dotfiles\vim\rc\init.lua"

mkdir %USERPROFILE%"\AppData\Local\nvim" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mklink "init.lua" %HOMEPATH%"\dotfiles\vim\rc\init.lua"

cd %HOMEPATH%

mklink ".flake8" %HOMEPATH%"\dotfiles\lint\python\.flake8"
mklink ".vintrc.yaml" %HOMEPATH%"\dotfiles\lint\vim\.vintrc.yaml"

mklink ".gitignore_global" %HOMEPATH%"\dotfiles\git\.gitignore_global"

mklink ".wslconfig" %HOMEPATH%"\dotfiles\setup\windows\.wslconfig"

mkdir %HOMEPATH%"\app" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mkdir %HOMEPATH%"\.local" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mkdir %HOMEPATH%"\workspace" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

cd %HOMEPATH%"\.config"
copy %HOMEPATH%"\dotfiles\setup\windows\lemonade.toml" "lemonade.toml" /Y

mkdir %APPDATA%"\Code\User" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mklink %APPDATA%"\Code\User\keybindings.json" %HOMEPATH%"\dotfiles\vscode\keybindings.json"
mklink %APPDATA%"\Code\User\settings.json" %HOMEPATH%"\dotfiles\vscode\settings.json"

pause
