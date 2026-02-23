$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Determine architecture - ARM64 builds use aarch64 naming
if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') {
$url64      = 'https://github.com/amnweb/yasb/releases/download/v1.9.0/yasb-1.9.0-aarch64.msi'
  $checksum64 = 'E1FB13B4D0B115D1E773D2D15237EFCCD6950BAA7174A92EB85D05739CCE6683'
} else {
  $url64      = 'https://github.com/amnweb/yasb/releases/download/v1.9.0/yasb-1.9.0-x64.msi'
  $checksum64 = '04E1C46A0A50025E91B57BF0E17AA93C4041EF23C4B8F1D2F0216113AB328675'
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