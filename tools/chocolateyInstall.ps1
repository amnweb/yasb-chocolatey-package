$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Determine architecture - ARM64 builds use aarch64 naming
if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') {
$url64      = 'https://github.com/amnweb/yasb/releases/download/v2.0.6/yasb-2.0.6-aarch64.msi'
  $checksum64 = '3FF65F36F44D9722D078B5719E4EBA3F536F4B0ACA4B6A33F95F169A25800694'
} else {
  $url64      = 'https://github.com/amnweb/yasb/releases/download/v2.0.6/yasb-2.0.6-x64.msi'
  $checksum64 = '0079D64993EFA08E196EC8CAA189558317B5BAC2D473E5F8C392250D844F7D1B'
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