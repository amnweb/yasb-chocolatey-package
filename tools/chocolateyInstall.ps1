$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Determine architecture - ARM64 builds use aarch64 naming
if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') {
  $url64      = 'https://github.com/amnweb/yasb/releases/download/v1.8.5/yasb-1.8.5-aarch64.msi'
  $checksum64 = '3E0266BD6028C9A1C1216AEE0EA1E5C905E1EE9C5F19CC266B8205B9C12D078E'
} else {
  $url64      = 'https://github.com/amnweb/yasb/releases/download/v1.8.5/yasb-1.8.5-x64.msi'
  $checksum64 = 'A264FB07D3AA9EA5D4D8725642A4D58932F5A3F67E77028C46D1739B6593D26D'
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