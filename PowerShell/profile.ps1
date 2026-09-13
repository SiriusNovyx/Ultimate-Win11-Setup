# ==============================================================================
# PowerShell 7 Profile
# Unified with WindowsPowerShell\Microsoft.PowerShell_profile.ps1
# ==============================================================================
$unifiedProfile = "$HOME\OneDrive\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
if (-not (Test-Path $unifiedProfile)) {
    $unifiedProfile = "$PSScriptRoot\..\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
}

if (Test-Path $unifiedProfile) {
    . $unifiedProfile
}