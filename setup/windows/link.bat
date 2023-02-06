cd %USERPROFILE%

mkdir %USERPROFILE%"\.vim" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mklink /D %USERPROFILE%"\.vim\lua" %USERPROFILE%"\dotfiles\vim\lua"
mklink /D %USERPROFILE%"\.vim\snippets" %USERPROFILE%"\dotfiles\vim\snippets"
mklink /D %USERPROFILE%"\.vim\after" %USERPROFILE%"\dotfiles\vim\after"
mklink /D %USERPROFILE%"\.vim\syntax" %USERPROFILE%"\dotfiles\vim\syntax"
mklink /D %USERPROFILE%"\.vim\ftdetect" %USERPROFILE%"\dotfiles\vim\ftdetect"
mklink %USERPROFILE%"\.vim\init.lua" %USERPROFILE%"\dotfiles\vim\lua\notomo\init.lua"

mkdir %USERPROFILE%"\.vim\tmp" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mkdir %USERPROFILE%"\.config" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

cd %USERPROFILE%
mklink /D %USERPROFILE%"\AppData\Local\nvim" %USERPROFILE%"\.vim"
mklink ".wslconfig" %USERPROFILE%"\dotfiles\setup\windows\.wslconfig"

mkdir %USERPROFILE%"\app" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mkdir %USERPROFILE%"\.local" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mkdir %USERPROFILE%"\workspace" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mkdir %USERPROFILE%"\.config\wezterm" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

cd %USERPROFILE%"\.config\wezterm"
mklink "wezterm.lua" %USERPROFILE%"\dotfiles\tool\wezterm.lua"

mkdir %APPDATA%"\Code\User" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

mklink %APPDATA%"\Code\User\keybindings.json" %USERPROFILE%"\dotfiles\vscode\keybindings.json"
mklink %APPDATA%"\Code\User\settings.json" %USERPROFILE%"\dotfiles\vscode\settings.json"

mklink %APPDATA%"\Microsoft\Windows\Start Menu\Programs\Startup\hotkey.ahk" %USERPROFILE%"\dotfiles\tool\autohotkey\hotkey.ahk"

pause
