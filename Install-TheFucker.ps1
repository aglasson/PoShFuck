$dst = (Join-Path (@($env:PSModulePath.Split(';') | Where-Object {$_ -notlike $null})[0]) PoShFuck);
$pfk = (Join-Path $env:temp "poshfuck.zip")

New-Item -Path $dst -Type Directory -Force -ErrorAction SilentlyContinue

[Net.ServicePointManager]::SecurityProtocol = "tls12"
Invoke-WebRequest 'https://github.com/mattparkes/PoShFuck/archive/master.zip' -OutFile $pfk

$shell = New-Object -ComObject Shell.Application; $shell.Namespace($dst).copyhere(($shell.NameSpace($pfk)).items(),20)

Move-Item "$dst\PoShFuck-master\*" "$dst" -Force
Remove-Item "$dst\PoShFuck-master" -Recurse -Force
Remove-Item $pfk -Force

if (-not(Test-Path $profile)) {
	Write-Output "Import-Module PoShFuck" | Out-File $profile -Force -encoding utf8
	Write-Output "Created $profile"
} elseif ( -not(Select-String -Path $profile -Pattern "Import-Module PoShFuck")) {
	Write-Output "`nImport-Module PoShFuck" | Out-File $profile -Append -encoding utf8
	Write-Output "Added PoShFuck to profile"
}

Import-Module PoShFuck

Write-Output "Installation complete."
