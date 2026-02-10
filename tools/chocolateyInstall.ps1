$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Determine architecture - ARM64 builds use aarch64 naming
if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') {
  $url64      = 'https://github.com/amnweb/yasb/releases/download/v1.8.9/yasb-1.8.9-aarch64.msi'
  $checksum64 = 'E06C8D3330A277BEBAF3F1958A2F0E4052FF4AA926716B9DD16BD6762C55F14E'
} else {
  $url64      = 'https://github.com/amnweb/yasb/releases/download/v1.8.9/yasb-1.8.9-x64.msi'
  $checksum64 = '299F07871673A50962992F3C08551FF322EFD6F7A3D2871912AB652A9D116DF4'
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