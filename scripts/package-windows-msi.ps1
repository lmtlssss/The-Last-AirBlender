$ErrorActionPreference = "Stop"
$Root = Resolve-Path "$PSScriptRoot\.."
Set-Location $Root
cargo build --release
if (-not (Get-Command wix -ErrorAction SilentlyContinue)) {
  dotnet tool install --global wix --version 5.*
  $env:PATH += ";$env:USERPROFILE\.dotnet\tools"
}
New-Item -ItemType Directory -Force -Path dist | Out-Null
wix build packaging\windows\last-airblender.wxs -o dist\last-airblender_x86_64.msi
Write-Host "dist\last-airblender_x86_64.msi"
