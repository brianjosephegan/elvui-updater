param (
    [Parameter(Mandatory=$true)][string]$elvuiZipPath
 )

$tempFolderPath = Join-Path -Path $PSScriptRoot -ChildPath "temp"
if (Test-Path $tempFolderPath) {
    Remove-Item -Path $tempFolderPath -Recurse -Force
}
New-Item -Path $PSScriptRoot -Name "temp" -ItemType "directory"
Expand-Archive -Path $elvuiZipPath -DestinationPath $tempFolderPath -Force

Set-Variable wowFolderPath -Option Constant -Value "C:\Program Files (x86)\World of Warcraft"
$wowVersions = @("_classic_", "_classic_era_", "_retail_")
foreach ($wowVersion in $wowVersions) {
    $addOnsFolderPath = Join-Path $wowFolderPath -ChildPath $wowVersion | Join-Path -ChildPath "Interface" | Join-Path -ChildPath "AddOns"
    Copy-Item -Path $tempFolderPath\* -Destination $addOnsFolderPath -Recurse -Force
}

Remove-Item -Path $tempFolderPath -Recurse -Force