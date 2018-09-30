Write-Output "Installing Chocolatey"
Set-ExecutionPolicy AllSigned
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
