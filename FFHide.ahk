#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon

global hidden := false
global hiddenHwnd := 0
global savedX := 0
global savedY := 0
global savedW := 0
global savedH := 0
global savedMinMax := 0  ; -1=minimized, 0=normal, 1=maximized

+Del:: {
    global hidden, hiddenHwnd
    global savedX, savedY, savedW, savedH, savedMinMax

    if (!hidden) {
        hwnd := WinActive("ahk_exe firefox.exe")
        if !hwnd
            return

        hiddenHwnd := hwnd
        savedMinMax := WinGetMinMax("ahk_id " hwnd)

        if (savedMinMax != 0)
            WinRestore("ahk_id " hwnd)

        WinGetPos(&savedX, &savedY, &savedW, &savedH, "ahk_id " hwnd)

        workArea := GetMonitorWorkAreaForWindow(hwnd)

        ; Leave a tiny strip visible on the right edge
        visibleStrip := 1
        newX := workArea.right - visibleStrip
        newY := savedY

        ; Clamp Y so the window stays within the monitor work area vertically
        if (newY < workArea.top)
            newY := workArea.top
        if (newY + savedH > workArea.bottom)
            newY := workArea.bottom - savedH

        WinMove(newX, newY, savedW, savedH, "ahk_id " hwnd)
        hidden := true
    } else {
        if !hiddenHwnd || !WinExist("ahk_id " hiddenHwnd) {
            hidden := false
            hiddenHwnd := 0
            return
        }

        WinRestore("ahk_id " hiddenHwnd)
        WinMove(savedX, savedY, savedW, savedH, "ahk_id " hiddenHwnd)

        if (savedMinMax = 1)
            WinMaximize("ahk_id " hiddenHwnd)
        else if (savedMinMax = -1)
            WinMinimize("ahk_id " hiddenHwnd)

        hidden := false
        hiddenHwnd := 0
    }
}

GetMonitorWorkAreaForWindow(hwnd) {
    MonitorGetWorkArea(MonitorGetPrimary(), &left, &top, &right, &bottom)

    try {
        WinGetPos(&wx, &wy, &ww, &wh, "ahk_id " hwnd)
        centerX := wx + (ww // 2)
        centerY := wy + (wh // 2)

        monitorCount := MonitorGetCount()
        Loop monitorCount {
            MonitorGetWorkArea(A_Index, &l, &t, &r, &b)
            if (centerX >= l && centerX < r && centerY >= t && centerY < b)
                return {left: l, top: t, right: r, bottom: b}
        }
    }

    return {left: left, top: top, right: right, bottom: bottom}
}