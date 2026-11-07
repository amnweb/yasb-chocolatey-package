$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Determine architecture - ARM64 builds use aarch64 naming
if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') {
$url64      = 'https://github.com/amnweb/yasb/releases/download/v2.0.8/yasb-2.0.8-aarch64.msi'
  $checksum64 = 'EBD00EC77B438FDFDADC8895D2277EFFE1606EF17B93BD86465632861B7B3314'
} else {
  $url64      = 'https://github.com/amnweb/yasb/releases/download/v2.0.8/yasb-2.0.8-x64.msi'
  $checksum64 = 'FE1197BF739117BE7C29CC858A4852F0A6C9E23134F094F6630F539347051404'
}

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url64bit      = $url64
  softwareName  = 'yasb*'
  checksum64    = $checksum64
  checksumType64= 'sha256'
  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs