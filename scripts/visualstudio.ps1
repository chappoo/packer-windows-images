if ($env:VS2017 -eq "true")
{
    Write-Output "Installing Visual Studio 2017"
    Invoke-WebRequest -Uri "https://aka.ms/vs/15/release/vs_community.exe" -OutFile "$env:windir\Temp\vs_community.exe"
    Start-Process -FilePath "$env:windir\Temp\vs_community.exe" -NoNewWindow -Wait -ArgumentList `
        "--quiet", `
        "--wait", `
        "--norestart", `
        "--locale en-US", `
        "--add Microsoft.VisualStudio.Workload.Data;includeRecommended;includeOptional", `
        "--add Microsoft.VisualStudio.Workload.ManagedDesktop;includeRecommended;includeOptional", `
        "--add Microsoft.VisualStudio.Workload.NetCoreTools;includeRecommended;includeOptional", `
        "--add Microsoft.VisualStudio.Workload.NetWeb;includeRecommended;includeOptional", `
        "--add Microsoft.VisualStudio.Workload.Node;includeRecommended;includeOptional"
    Remove-Item "$env:windir\Temp\vs_community.exe"
}

if ($env:VS2017_BUILDTOOLS -eq "true")
{
    Start-Process -FilePath "C:\ProgramData\chocolatey\bin\choco.exe" -NoNewWindow -Wait -ArgumentList `
        "install", `
        "-y", `
        "visualstudio2017buildtools", `
        "--package-parameters", `
        "`" --add Microsoft.VisualStudio.Workload.DataBuildTools;includeRecommended;includeOptional --add Microsoft.VisualStudio.Workload.ManagedDesktopBuildTools;includeRecommended;includeOptional --add Microsoft.VisualStudio.Workload.MSBuildTools;includeRecommended;includeOptional --add Microsoft.VisualStudio.Workload.NetCoreBuildTools;includeRecommended;includeOptional --add Microsoft.VisualStudio.Workload.WebBuildTools;includeRecommended;includeOptional --passive --locale en-US`""
}