; AutoHotkey Script to Auto-Delete Discord DMs in Specified Order
; Press F9 to start the delete loop, and F10 to stop

#Persistent ; Keeps the script running
SetTitleMatchMode, 2 ; Matches the Discord window
DetectHiddenWindows, On

deleteInterval := 10 ; Interval in milliseconds between each loop (adjust as needed)
looping := false ; Keeps track of the loop state

; F9 to toggle the delete loop on/off
F9::
    looping := !looping
    if (looping) {
        MsgBox, Auto-delete DMs started. Press F10 to stop.
        SetTimer, DeleteMessages, %deleteInterval%
    } else {
        MsgBox, Auto-delete DMs stopped.
        SetTimer, DeleteMessages, Off
    }
return

DeleteMessages:
    if (!looping) {
        return
    }

    ; Step 1: Press Enter (if needed to clear dialogs or confirm actions)
    Send, {Enter}
    Sleep, 100 ; Brief delay

    ; Step 2: Press Backspace (start delete process)
    Send, {Backspace}
    Sleep, 200 ; Brief delay to ensure Backspace is processed

    ; Step 3: Move up to the previous message with Up Arrow
    Send, {Up}
    Sleep, 200 ; Short delay to ensure previous message is selected

    ; Step 4: Select all text in the message with Ctrl + A
    Send, ^a
    Sleep, 100 ; Brief pause to ensure selection

    ; Step 5: Press Backspace to delete selected message
    Send, {Backspace}
    Sleep, 200 ; Pause for the delete confirmation prompt to appear

    ; Step 6: Confirm delete by pressing Enter three times
    Send, {Enter}
    Sleep, 100 ; Pause between each Enter press for stability
    Send, {Enter}
    Sleep, 100
    Send, {Enter}

    ; Step 7: Final Backspace
    Send, {Backspace}
    Sleep, 200 ; Brief delay to ensure deletion is processed

return

; F10 to stop the script
F10::
    looping := false
    SetTimer, DeleteMessages, Off
    MsgBox, Auto-delete script stopped.
return
