Write-Host "Stopping service: wuauserv"
Stop-Service -Name wuauserv
Write-Host "Stopped service: wuauserv"

$RegistryKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update"
$RegistryEntry = "EnableFeaturedSoftware"
Set-ItemProperty -Path $RegistryKey -Name $RegistryEntry -Value 1

$RegistryEntry = "IncludeRecommendedUpdates"
Set-ItemProperty -Path $RegistryKey -Name $RegistryEntry -Value 1

'Set ServiceManager = CreateObject("Microsoft.Update.ServiceManager")' | Set-Content A:\temp.vbs
'Set NewUpdateService = ServiceManager.AddService2("7971f918-a847-4430-9279-4a52d1efe18d",7,"")' | Add-Content A:\temp.vbs

Write-Host "Executing cscript"
Start-Process -FilePath "cmd" -ArgumentList "/C cscript A:\temp.vbs" -NoNewWindow -Wait
Write-Host "Executed cscript"

Write-Host "Starting service: wuauserv"
Start-Service -Name wuauserv
Write-Host "Started service: wuauserv"