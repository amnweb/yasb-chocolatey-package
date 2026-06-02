$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Determine architecture - ARM64 builds use aarch64 naming
if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') {
$url64      = 'https://github.com/amnweb/yasb/releases/download/v2.0.2/yasb-2.0.2-aarch64.msi'
  $checksum64 = '9FC7906A4E6DEF3F686DC86BA377AB37A26123CA1C7E36393E4A4E11D84057DE'
} else {
  $url64      = 'https://github.com/amnweb/yasb/releases/download/v2.0.2/yasb-2.0.2-x64.msi'
  $checksum64 = '4BE56686574ED82B0DE920E874674C6B509BBD5FC52B69DC9678BF8011BEA899'
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