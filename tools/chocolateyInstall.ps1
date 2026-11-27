$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Determine architecture - ARM64 builds use aarch64 naming
if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') {
$url64      = 'https://github.com/amnweb/yasb/releases/download/v2.0.9/yasb-2.0.9-aarch64.msi'
  $checksum64 = '649ACA03D1EA115BF96CE402266AC920806B14E2BBA21FC9458E29C5203384A4'
} else {
  $url64      = 'https://github.com/amnweb/yasb/releases/download/v2.0.9/yasb-2.0.9-x64.msi'
  $checksum64 = '910B1162968912328FB1BB7DD2F052F0BCF27B6C24C669EF229B91B000CC85CD'
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