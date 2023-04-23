#Warn All, StdOut
#SingleInstance

#Include "send.ahk"

EDITOR := "WSL"
BROWSER := "ahk_exe chrome.exe"

; https://lexikos.github.io/v2/docs/Hotkeys.htm#Symbols

; ^ = Control
; # = Win
; + = Shift

^#n::
{
    Run("wezterm.exe start --position 0,0 nvim", , "Hide")
}

^#h::
{
    SendToAllWindows("#+{Left}")
}

^#l::
{
    SendToAllWindows("#+{Right}")
}

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

#HotIf WinActive(BROWSER)
^e::
{
    Send "{End}"
}

#HotIf WinActive(BROWSER)
^h::
{
    Send "{BS}"
}

#HotIf WinActive(BROWSER)
^b::
{
    Send "{Left}"
}

; #HotIf WinActive(BROWSER)
; ^f::
; {
;     Send "{Right}"
; }

#HotIf WinActive(BROWSER)
^u::
{
    Send "^+{Left}{Delete}"
}

#HotIf WinActive(BROWSER)
^k::
{
    Send "^+{Right}{Delete}"
}

#HotIf WinActive(BROWSER)
^d::
{
    Send "{Delete}"
}

#HotIf WinActive(BROWSER)
^n::
{
    Send "{Down}"
}

#HotIf WinActive(BROWSER)
^p::
{
    Send "{Up}"
}
