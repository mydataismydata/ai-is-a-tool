# Enable these hooks for EVERY git repo on this machine — existing and any you
# start later — by pointing git's global core.hooksPath at this repo's hooks/.
#
# Run once per machine. To update the hook later, just `git pull` in this clone.
$ErrorActionPreference = 'Stop'
$hooks = (Join-Path $PSScriptRoot 'hooks') -replace '\\', '/'
git config --global core.hooksPath $hooks
Write-Host "Global git hooks enabled."
Write-Host "  core.hooksPath = $hooks"
Write-Host "Active in every repo on this machine."
Write-Host "(git commit --no-verify bypasses hooks - don't.)"
