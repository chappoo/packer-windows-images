function CheckAndDownload() {
    param (
        [string]$FilePath,
        [string]$DownloadUrl
    )

    if (-not (Test-Path -Path $FilePath)) {
        $webclient = New-Object System.Net.WebClient
        $webclient.DownloadFile($DownloadUrl,$FilePath)
    }
}

CheckAndDownload -FilePath "$env:windir\Temp\7z920-x64.msi" -DownloadUrl "http://www.7-zip.org/a/7z920-x64.msi"
CheckAndDownload -FilePath "$env:windir\Temp\ultradefrag.zip" -DownloadUrl "http://downloads.sourceforge.net/project/ultradefrag/stable-release/6.1.0/ultradefrag-portable-6.1.0.bin.amd64.zip"
CheckAndDownload -FilePath "$env:windir\Temp\SDelete.zip" -DownloadUrl "http://download.sysinternals.com/files/SDelete.zip"

Start-Process -FilePath "msiexec" -ArgumentList "/qb /i $env:windir\Temp\7z920-x64.msi" -NoNewWindow -Wait
Start-Process -FilePath "cmd" -ArgumentList "/c `"C:\Program Files\7-Zip\7z.exe`" x $env:windir\Temp\ultradefrag.zip -o$env:windir\Temp" -NoNewWindow -Wait
Start-Process -FilePath "cmd" -ArgumentList "/c `"C:\Program Files\7-Zip\7z.exe`" x $env:windir\Temp\SDelete.zip -o$env:windir\Temp" -NoNewWindow -Wait
Start-Process -FilePath "msiexec" -ArgumentList "/qb /x $env:windir\Temp\7z920-x64.msi" -NoNewWindow -Wait

Write-Host "Stopping service: wuauserv"
Stop-Service -Name wuauserv
Write-Host "Stopped service: wuauserv"

Remove-Item -Path "$env:windir\SoftwareDistribution\Download" -Recurse -Force
New-Item -Path "$env:windir\SoftwareDistribution\Download" -ItemType Directory

Write-Host "Starting service: wuauserv"
Start-Service -Name wuauserv
Write-Host "Started service: wuauserv"

Start-Process -FilePath "cmd" -ArgumentList "/c $env:windir\Temp\ultradefrag-portable-6.1.0.amd64\udefrag.exe --optimize --repeat C:" -NoNewWindow -Wait

$RegistryKey = "HKCU:\Software\Sysinternals\SDelete"
$RegistryEntry = "EulaAccepted"
New-Item -Path $RegistryKey -Force
Set-ItemProperty -Path $RegistryKey -Name $RegistryEntry -Value 1

Start-Process -FilePath "cmd" -ArgumentList "/c $env:windir\Temp\sdelete.exe -q -z C:" -NoNewWindow -Wait

Write-Host "Clearing Temp folders"
Remove-Item -Path "$env:windir\Temp" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$env:TEMP" -Recurse -Force -ErrorAction SilentlyContinue
