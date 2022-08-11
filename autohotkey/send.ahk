#Warn All, StdOut
#SingleInstance

SendToAllWindows(key)
{
    currentWindowId := WinGetID("A")
    for id in WinGetList(, , "Program Manager")
    {
        WinActivate(id)
        Send(key)
    }
    WinActivate(currentWindowId)
}
