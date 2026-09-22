# ==============================================================================
# PowerShell 7 Host Profile (Microsoft.PowerShell_profile.ps1)
# Dot-sources the unified profile
# ==============================================================================
$unifiedProfile = "$HOME\OneDrive\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
if (-not (Test-Path $unifiedProfile)) {
    $unifiedProfile = "$PSScriptRoot\..\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
}
if (Test-Path $unifiedProfile) {
    . $unifiedProfile
}
