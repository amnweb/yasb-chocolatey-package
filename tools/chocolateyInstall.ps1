$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Determine architecture - ARM64 builds use aarch64 naming
if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') {
  $url64      = 'https://github.com/amnweb/yasb/releases/download/v1.8.7/yasb-1.8.7-aarch64.msi'
  $checksum64 = 'D78DAECF62B922B0B86A557C58C21024AB25D70B0FD8EA16EACF40F4BE108C4F'
} else {
  $url64      = 'https://github.com/amnweb/yasb/releases/download/v1.8.7/yasb-1.8.7-x64.msi'
  $checksum64 = 'DD5286968499C6D596107F107E28F73B8015F86737E731CC8D3DE78A2547AB9B'
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