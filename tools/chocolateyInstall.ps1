$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Determine architecture - ARM64 builds use aarch64 naming
if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') {
$url64      = 'https://github.com/amnweb/yasb/releases/download/v2.0.7/yasb-2.0.7-aarch64.msi'
  $checksum64 = '9E9E2C49781A00187316177D2DABCC4B4A253C0BF3A241EDA5FA443C149F5F0B'
} else {
  $url64      = 'https://github.com/amnweb/yasb/releases/download/v2.0.7/yasb-2.0.7-x64.msi'
  $checksum64 = 'C93B3EB24FCEB64B8BAEFE694A947FECD31A7E58F0939BA61296048124EDBE8B'
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