#Warn All, StdOut
#SingleInstance

EDITOR := "WSL"
BROWSER := "ahk_exe chrome.exe"

; https://lexikos.github.io/v2/docs/Hotkeys.htm#Symbols

#HotIf WinActive(EDITOR)
^#j::
{
    WinActivate(BROWSER)
}
#HotIf !WinActive(EDITOR)
^#j::
{
    WinActivate(EDITOR)
}
