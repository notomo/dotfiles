cd %USERPROFILE%

mkdir %USERPROFILE%"\.config" > NUL 2>&1
if ERRORLEVEL 1 cmd /c exit 0

cd %USERPROFILE%
mklink /D %USERPROFILE%"\AppData\Local\nvim\lua" %USERPROFILE%"\dotfiles\vim\lua"
mklink /D %USERPROFILE%"\AppData\Local\nvim\snippets" %USERPROFILE%"\dotfiles\vim\snippets"
mklink /D %USERPROFILE%"\AppData\Local\nvim\after" %USERPROFILE%"\dotfiles\vim\after"
mklink %USERPROFILE%"\AppData\Local\nvim\init.lua" %USERPROFILE%"\dotfiles\vim\lua\notomo\init.lua"

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

mklink %APPDATA%"\Code\User\keybindings.json" %USERPROFILE%"\dotfiles\tool\vscode\keybindings.json"
mklink %APPDATA%"\Code\User\settings.json" %USERPROFILE%"\dotfiles\tool\vscode\settings.json"

mklink %APPDATA%"\Microsoft\Windows\Start Menu\Programs\Startup\hotkey.ahk" %USERPROFILE%"\dotfiles\tool\autohotkey\hotkey.ahk"

pause
