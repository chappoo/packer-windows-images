$RegistryKey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
$RegistryEntry = "AutoAdminLogon"
Set-ItemProperty -Path $RegistryKey -Name $RegistryEntry -Value 0
