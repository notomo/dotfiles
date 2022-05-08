cd %USERPROFILE%

mkdir %USERPROFILE%"\.vim" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mklink /D %USERPROFILE%"\.vim\lua" %USERPROFILE%"\dotfiles\vim\lua"
mklink /D %USERPROFILE%"\.vim\snippets" %USERPROFILE%"\dotfiles\vim\snippets"
mklink /D %USERPROFILE%"\.vim\after" %USERPROFILE%"\dotfiles\vim\after"
mklink /D %USERPROFILE%"\.vim\ftplugin" %USERPROFILE%"\dotfiles\vim\ftplugin"
mklink /D %USERPROFILE%"\.vim\syntax" %USERPROFILE%"\dotfiles\vim\syntax"
mklink /D %USERPROFILE%"\.vim\indent" %USERPROFILE%"\dotfiles\vim\indent"
mklink /D %USERPROFILE%"\.vim\ftdetect" %USERPROFILE%"\dotfiles\vim\ftdetect"
mklink %USERPROFILE%"\.vim\init.lua" %USERPROFILE%"\dotfiles\vim\lua\notomo\init.lua"

mkdir %USERPROFILE%"\.vim\tmp" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mkdir %USERPROFILE%"\.vim\reference" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mkdir %USERPROFILE%"\.config" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

cd %USERPROFILE%
mklink /D %USERPROFILE%"\AppData\Local\nvim" %USERPROFILE%"\.vim"
mklink ".flake8" %USERPROFILE%"\dotfiles\lint\python\.flake8"
mklink ".gitignore_global" %USERPROFILE%"\dotfiles\git\.gitignore_global"
mklink ".wslconfig" %USERPROFILE%"\dotfiles\setup\windows\.wslconfig"

mkdir %USERPROFILE%"\app" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mkdir %USERPROFILE%"\.local" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mkdir %USERPROFILE%"\workspace" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

cd %USERPROFILE%"\.config"
copy %USERPROFILE%"\dotfiles\setup\windows\lemonade.toml" "lemonade.toml" /Y

mkdir %APPDATA%"\Code\User" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mklink %APPDATA%"\Code\User\keybindings.json" %USERPROFILE%"\dotfiles\vscode\keybindings.json"
mklink %APPDATA%"\Code\User\settings.json" %USERPROFILE%"\dotfiles\vscode\settings.json"

pause
