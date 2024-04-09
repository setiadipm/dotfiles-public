Write-Host "`n`n# HELLO WINDOWS USER! #"

Write-Host "`n`n# Setting up machine... #"

$scoopDir = "Program Files\Scoop"
$scoopGlobalDir = "Program Files\Scoop\apps"
$scoopShimsDir = "Program Files\Scoop\shims"
$scoopEnvVar = "SCOOP"
$scoopGlobalEnvVar = "SCOOP_GLOBAL"

$driveLetter = Read-Host "`nThe setup is using Scoop as package manager. `nWhich drive would you like to install to? (e.g. C, D, etc.)"
if (-not (Test-Path "$driveLetter`:" -PathType Container)) {
  Write-Host "Drive $driveLetter is not a valid drive!`n"
  Exit
}
$scoopPath = "$driveLetter`:\$scoopDir"
$scoopGlobalPath = "$driveLetter`:\$scoopGlobalDir"
$scoopShimsPath = "$driveLetter`:\$scoopShimsDir"

Set-ExecutionPolicy Bypass -Scope Process
Write-Host "    --> Installing chocolatey..."
if (-not ([Boolean](Get-Command choco -ErrorAction SilentlyContinue))) {
  Invoke-WebRequest -Uri "https://community.chocolatey.org/install.ps1" | Invoke-Expression | Out-Null
}
Write-Host "    --> Installing scoop..."
if (-not ([Boolean](Get-Command scoop -ErrorAction SilentlyContinue))) {
  Invoke-WebRequest -Uri "https://get.scoop.sh" -OutFile "scoop-install.ps1" | Out-Null
  & .\scoop-install.ps1 -RunAsAdmin -ScoopDir $scoopPath -ScoopGlobalDir $scoopGlobalPath | Out-Null
  Remove-Item -Path ".\scoop-install.ps1" | Out-Null
}
[System.Environment]::SetEnvironmentVariable($scoopEnvVar, $scoopPath, [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable($scoopGlobalEnvVar, $scoopGlobalPath, [System.EnvironmentVariableTarget]::Machine)
$env:SCOOP = $scoopPath
$env:SCOOP_GLOBAL = $scoopGlobalPath
$currentUserPath = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::User)
if ($currentUserPath -notlike "*$scoopShimsPath*") {
  [System.Environment]::SetEnvironmentVariable("PATH", "$currentUserPath;$scoopShimsPath", [System.EnvironmentVariableTarget]::User)
}
$env:Path = [Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine) + ";" + [Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::User)
$scoopApps = @(
  "main/7zip"
  "main/git"
  "main/chezmoi"
)
foreach ($app in $scoopApps) {
  Write-Host "    --> Installing $app..."
  Invoke-Expression -Command "scoop install $app" | Out-Null
}

Write-Host ""
