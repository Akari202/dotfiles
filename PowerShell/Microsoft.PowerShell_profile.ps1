Invoke-Expression (& { (zoxide init powershell | Out-String) })
Set-Alias python "C:\Users\aharada\AppData\Local\Programs\Python\Python314\python.exe"
Set-PSReadlineOption -EditMode vi
Set-PSReadlineOption -ViModeIndicator Cursor
Set-PSReadLineKeyHandler -Chord "RightArrow" -Function ForwardWord
# Set-PSReadLineKeyHandler -Function AcceptNextSuggestionWord -Chord "Shift+Tab"
# Set-PSReadLineKeyHandler -Function AcceptSuggestion -Chord "Shift+Tab"
Set-PSReadLineKeyHandler -Function AcceptSuggestion -Chord "Tab"
Set-PSReadLineKeyHandler -Function Complete -Chord "Shift+Tab"
