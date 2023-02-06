#Warn All, StdOut
#SingleInstance

TIMEOUT := 1000

currentWindowId := WinGetID("A")
for _, target in A_Args
    Run(target)
WinWaitNotActive("ahk_id " currentWindowId, , TIMEOUT)
WinActivate(currentWindowId)
