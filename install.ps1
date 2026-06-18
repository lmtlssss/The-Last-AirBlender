$ErrorActionPreference = "Stop"
$Repo = "lmtlssss/The-Last-AirBlender"
$Version = $env:LAST_AIRBLENDER_VERSION
if (-not $Version) { $Base = "https://github.com/$Repo/releases/latest/download" } else { $Base = "https://github.com/$Repo/releases/download/$Version" }
$Arch = if ([Environment]::Is64BitOperatingSystem) { "x86_64" } else { throw "Only 64-bit Windows is supported" }
$Asset = "last-airblender_${Arch}.msi"
$Tmp = New-Item -ItemType Directory -Force -Path ([System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), "last-airblender-install"))
Invoke-WebRequest "$Base/checksums.txt" -OutFile "$Tmp\checksums.txt"
Invoke-WebRequest "$Base/$Asset" -OutFile "$Tmp\$Asset"
Push-Location $Tmp
$Expected = (Select-String -Path checksums.txt -Pattern $Asset).Line.Split()[0].ToLower()
$Actual = (Get-FileHash $Asset -Algorithm SHA256).Hash.ToLower()
if ($Expected -ne $Actual) { throw "checksum mismatch for $Asset" }
Pop-Location
Start-Process msiexec.exe -Wait -ArgumentList "/i", "$Tmp\$Asset"
last-airblender install
last-airblender doctor
