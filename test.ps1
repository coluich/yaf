$imageUrl = "https://thumbs.dreamstime.com/b/man-screams-fear-horror-pop-art-retro-vector-illustration-103789731.jpg"
$outputPath = "$env:USERPROFILE\sfondo.jpg"

function Set-Wallpaper {
    param($path)
    $RegKeyPath = "HKCU:\Control Panel\Desktop"
    Set-ItemProperty -Path $RegKeyPath -Name Wallpaper -Value $path
    rundll32.exe user32.dll, UpdatePerUserSystemParameters 1, True
    Start-Sleep -Milliseconds 300
    Add-Type -TypeDefinition @'
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
'@
    [Wallpaper]::SystemParametersInfo(0x0014, 0, $path, 0x01)
}

$attempts = 0
$maxAttempts = 3
$success = $false

while ($attempts -lt $maxAttempts -and -not $success) {
    $attempts++
    
    # Scarica o riscarica il file ogni tentativo
    if (Test-Path -Path $outputPath) {
        Remove-Item -Path $outputPath -Force
    }
    
    try {
        Invoke-WebRequest -Uri $imageUrl -OutFile $outputPath
        Start-Sleep -Seconds 1
        
        if (Test-Path -Path $outputPath) {
            Set-Wallpaper -path $outputPath
            $success = $true
        }
    }
    catch {
        Start-Sleep -Seconds 2
    }
}
