$imageUrl = "https://thumbs.dreamstime.com/b/man-screams-fear-horror-pop-art-retro-vector-illustration-103789731.jpg"
$outputPath = "$env:USERPROFILE\sfondo.jpg"

# Verifica se l'immagine esiste già
if (-not (Test-Path -Path $outputPath)) {
    # Crea un job per scaricare l'immagine solo se non esiste
    $job = Start-Job -ScriptBlock {
        param($url, $path)
        Invoke-WebRequest -Uri $url -OutFile $path
    } -ArgumentList $imageUrl, $outputPath
    
    # Attende il completamento del job
    Wait-Job -Job $job | Out-Null
    # Pulisce il job
    Remove-Job -Job $job
}

# Imposta lo sfondo (anche se già scaricato in precedenza)
$RegKeyPath = "HKCU:\Control Panel\Desktop"
Set-ItemProperty -Path $RegKeyPath -Name Wallpaper -Value $outputPath
# Aggiorna le impostazioni dello sfondo
rundll32.exe user32.dll, UpdatePerUserSystemParameters
RUNDLL32.EXE USER32.DLL, UpdatePerUserSystemParameters 1, True
