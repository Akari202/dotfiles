Invoke-Expression (& { (zoxide init powershell | Out-String) })
Set-Alias python "C:\Users\aharada\AppData\Local\Programs\Python\Python314\python.exe"
Set-Alias python3 "C:\Users\aharada\AppData\Local\Programs\Python\Python314\python.exe"
function coverage { C:\Users\aharada\AppData\Local\Programs\Python\Python314\python.exe -m coverage }
Set-Alias octave "C:\Users\aharada\AppData\Local\Programs\GNU Octave\Octave-10.3.0\mingw64\bin\octave-cli.exe"
Set-PSReadlineOption -EditMode vi
Set-PSReadlineOption -ViModeIndicator Cursor
Set-PSReadLineKeyHandler -Chord "RightArrow" -Function ForwardWord
# Set-PSReadLineKeyHandler -Function AcceptNextSuggestionWord -Chord "Shift+Tab"
# Set-PSReadLineKeyHandler -Function AcceptSuggestion -Chord "Shift+Tab"
Set-PSReadLineKeyHandler -Function AcceptSuggestion -Chord "Shift+Tab"
Set-PSReadLineKeyHandler -Function Complete -Chord "Tab"
