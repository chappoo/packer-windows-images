if (Test-Path -Path "$env:windir\microsoft.net\framework\v4.0.30319\ngen.exe")
{
	& $env:windir\microsoft.net\framework\v4.0.30319\ngen.exe update /force /queue
	& $env:windir\microsoft.net\framework\v4.0.30319\ngen.exe executequeueditems
}

if (Test-Path -Path "$env:windir\microsoft.net\framework64\v4.0.30319\ngen.exe") 
{
	& $env:windir\microsoft.net\framework64\v4.0.30319\ngen.exe update /force /queue
	& $env:windir\microsoft.net\framework64\v4.0.30319\ngen.exe executequeueditems
}

exit 0