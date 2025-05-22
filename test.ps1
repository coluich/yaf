$imageUrl = "https://thumbs.dreamstime.com/b/man-screams-fear-horror-pop-art-retro-vector-illustration-103789731.jpg"
$outputPath = "$env:USERPROFILE\sfondo.jpg"

function Set-Wallpaper {
    param($path)
    $RegKeyPath = "HKCU:\Control Panel\Desktop"
    Set-ItemProperty -Path $RegKeyPath -Name Wallpaper -Value $path
    rundll32.exe user32.dll, UpdatePerUserSystemParameters 1, True
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
    
    # Elimina il file esistente se presente
    if (Test-Path -Path $outputPath) {
        Remove-Item -Path $outputPath -Force
    }
    
    # Avvia il download in background con job
    $job = Start-Job -ScriptBlock {
        param($url, $path)
        try {
            Invoke-WebRequest -Uri $url -OutFile $path -ErrorAction Stop
            return $true
        } catch {
            return $false
        }
    } -ArgumentList $imageUrl, $outputPath
    
    # Attesa intelligente del completamento del job
    $jobCompleted = $false
    $timeout = 30  # timeout in secondi
    $startTime = Get-Date
    
    while (-not $jobCompleted -and ((Get-Date) - $startTime).TotalSeconds -lt $timeout) {
        if ($job.State -ne 'Running') {
            $jobCompleted = $true
        }
        Start-Sleep -Milliseconds 100
    }
    
    # Verifica risultato
    if ($jobCompleted -and (Receive-Job -Job $job) -and (Test-Path -Path $outputPath)) {
        Set-Wallpaper -path $outputPath
        $success = $true
    }
    
    # Pulizia job
    Remove-Job -Job $job -Force
}

# Pulizia finale
Get-Job | Remove-Job -Force
