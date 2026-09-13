# ==============================================================================
# PowerShell Profile - Catppuccin Aesthetic & Modern Productivity
# Target: Microsoft.PowerShell_profile.ps1 (Compatible with PS 5.1 and PS 7+)
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. UTF-8 Console Encoding
# ------------------------------------------------------------------------------
try {
    [Console]::InputEncoding  = [System.Text.Encoding]::UTF8
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    $OutputEncoding = [System.Text.UTF8Encoding]::new($false)
    chcp 65001 > $null
} catch {}

# ------------------------------------------------------------------------------
# 2. Interactive Banner & Fastfetch (Bypasses non-interactive / redirected runs)
# ------------------------------------------------------------------------------
if (-not [Console]::IsOutputRedirected -and -not [Console]::IsInputRedirected) {
    try { Clear-Host } catch {}

    $fastfetchConfig = "$env:USERPROFILE\.config\fastfetch\config.jsonc"
    if (Get-Command fastfetch -ErrorAction SilentlyContinue) {
        if (Test-Path $fastfetchConfig) {
            fastfetch -c $fastfetchConfig
        } else {
            fastfetch
        }
    }
}

# ------------------------------------------------------------------------------
# 3. PSReadLine: Keybindings, Predictions & Catppuccin Highlighting
# ------------------------------------------------------------------------------
if (Get-Command Set-PSReadLineOption -ErrorAction SilentlyContinue) {
    try {
        Set-PSReadLineOption -EditMode Windows
        Set-PSReadLineOption -HistoryNoDuplicates:$true
        Set-PSReadLineOption -HistorySearchCursorMovesToEnd:$true

        # Up/Down arrows: Search history matching what you have typed so far
        Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
        Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

        # Tab: Interactive Menu Completion
        Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

        # Catppuccin Mocha / Macchiato Theme Syntax Colors
        $esc = [char]27
        $syntaxColors = @{
            Command            = "$esc[38;2;137;220;235m"  # Sky (#89DCEB)
            Parameter          = "$esc[38;2;203;166;247m"  # Lavender (#CBA6F7)
            Operator           = "$esc[38;2;148;226;213m"  # Teal (#94E2D5)
            Variable           = "$esc[38;2;245;224;220m"  # Rosewater (#F5E0DC)
            String             = "$esc[38;2;166;227;161m"  # Green (#A6E3A1)
            Number             = "$esc[38;2;250;179;135m"  # Peach (#FAB387)
            Type               = "$esc[38;2;249;226;175m"  # Yellow (#F9E2AF)
            Comment            = "$esc[38;2;108;112;134m"  # Overlay 0 (#6C7086)
            Error              = "$esc[38;2;243;139;168m"  # Red (#F38BA8)
            InlinePrediction   = "$esc[38;2;108;112;134m"  # Muted Gray-Blue
        }

        # Predictive IntelliSense (supports History + Plugins on PSReadLine 2.2+)
        $psr = Get-Module PSReadLine
        if ($psr -and $psr.Version -ge [Version]'2.2.0') {
            try {
                Set-PSReadLineOption -PredictionSource HistoryAndPlugin -ErrorAction Stop
            } catch {
                try { Set-PSReadLineOption -PredictionSource History } catch {}
            }
            try { Set-PSReadLineOption -PredictionViewStyle InlineView } catch {}

            # Auto-type keybindings:
            # RightArrow: accept full suggestion
            Set-PSReadLineKeyHandler -Key RightArrow -Function ForwardChar
            # Ctrl+f or Ctrl+RightArrow: auto-type word-by-word (accepts next word)
            Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function ForwardWord
            Set-PSReadLineKeyHandler -Key "Ctrl+RightArrow" -Function ForwardWord
            # Ctrl+Space: open completion menu
            Set-PSReadLineKeyHandler -Key "Ctrl+Space" -Function MenuComplete
            # F2: toggle between inline ghost text and interactive dropdown list
            Set-PSReadLineKeyHandler -Key F2 -Function SwitchPredictionView

            # Quick Auto-Type snippet chords:
            # Alt+g -> auto-types 'git status'
            Set-PSReadLineKeyHandler -Chord "Alt+g" -ScriptBlock {
                [Microsoft.PowerShell.PSConsoleReadLine]::Insert("git status")
            }
            # Alt+c -> auto-types 'code .'
            Set-PSReadLineKeyHandler -Chord "Alt+c" -ScriptBlock {
                [Microsoft.PowerShell.PSConsoleReadLine]::Insert("code .")
            }
            # Alt+u -> auto-types 'uv run '
            Set-PSReadLineKeyHandler -Chord "Alt+u" -ScriptBlock {
                [Microsoft.PowerShell.PSConsoleReadLine]::Insert("uv run ")
            }
        }

        Set-PSReadLineOption -Colors $syntaxColors

        # Pre-seed popular developer commands so Auto-Type can suggest them immediately
        try {
            $histFile = (Get-PSReadLineOption).HistorySavePath
            if ($histFile) {
                $histDir = Split-Path $histFile
                if (-not (Test-Path $histDir)) { New-Item -ItemType Directory -Path $histDir -Force | Out-Null }
                $starterSeeds = @(
                    'git status',
                    'git add -A',
                    'git commit -m "update"',
                    'git push origin main',
                    'git pull --rebase',
                    'git log --oneline -n 10',
                    'winget upgrade --all',
                    'winget search',
                    'uv pip install -r requirements.txt',
                    'python -m venv .venv',
                    'npm run dev',
                    'npm install',
                    'code .',
                    'fastfetch -c "$env:USERPROFILE\.config\fastfetch\config.jsonc"'
                )
                if (-not (Test-Path $histFile)) {
                    $starterSeeds | Out-File -FilePath $histFile -Encoding utf8
                } else {
                    $existing = Get-Content $histFile -ErrorAction SilentlyContinue
                    $toAdd = $starterSeeds | Where-Object { $_ -notin $existing }
                    if ($toAdd) {
                        $toAdd | Out-File -FilePath $histFile -Append -Encoding utf8
                    }
                }
            }
        } catch {}
    } catch {}
}

# ------------------------------------------------------------------------------
# 3.1 Smart Argument Completers (Auto-Type CLI Commands & Arguments)
# ------------------------------------------------------------------------------

# Git Completer: Auto-types Git subcommands, options & local/remote branches
if (Get-Command git -ErrorAction SilentlyContinue) {
    $script:gitSubcommands = @(
        'add', 'bisect', 'branch', 'checkout', 'clone', 'commit', 'diff',
        'fetch', 'grep', 'init', 'log', 'merge', 'mv', 'pull', 'push',
        'rebase', 'reset', 'restore', 'revert', 'rm', 'show', 'status',
        'switch', 'tag', 'stash'
    )
    Register-ArgumentCompleter -Native -CommandName git -ScriptBlock {
        param($wordToComplete, $commandAst, $cursorPosition)
        $elements = $commandAst.CommandElements
        if ($elements.Count -le 2) {
            $script:gitSubcommands | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
                [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', "Git command: $_")
            }
        } elseif ($elements[1].Value -in @('checkout', 'switch', 'branch', 'merge', 'rebase', 'pull', 'diff', 'log')) {
            git branch --format='%(refname:short)' 2>$null | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
                [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', "Branch: $_")
            }
        }
    }
}

# Winget Completer: Auto-types winget commands and options
if (Get-Command winget -ErrorAction SilentlyContinue) {
    Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
        param($wordToComplete, $commandAst, $cursorPosition)
        $subcommands = @('install', 'show', 'source', 'search', 'list', 'upgrade', 'uninstall', 'hash', 'validate', 'settings', 'features', 'export', 'import', 'pin')
        $options = @('--id', '--name', '--exact', '-e', '--source', '-s', '--scope', '--silent', '-h', '--force', '--all')
        if ($wordToComplete.StartsWith('-')) {
            $options | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
                [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
            }
        } else {
            $subcommands | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
                [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
            }
        }
    }
}

# uv Completer: Auto-types uv subcommands
if (Get-Command uv -ErrorAction SilentlyContinue) {
    $script:uvCommands = @('run', 'init', 'add', 'remove', 'lock', 'sync', 'tree', 'pip', 'venv', 'python', 'tool', 'cache', 'help')
    Register-ArgumentCompleter -Native -CommandName uv -ScriptBlock {
        param($wordToComplete, $commandAst, $cursorPosition)
        $script:uvCommands | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', "uv: $_")
        }
    }
}

# npm Completer: Auto-types npm scripts & commands
if (Get-Command npm -ErrorAction SilentlyContinue) {
    $script:npmCommands = @('run', 'install', 'i', 'test', 'build', 'start', 'dev', 'publish', 'update', 'audit', 'init')
    Register-ArgumentCompleter -Native -CommandName npm -ScriptBlock {
        param($wordToComplete, $commandAst, $cursorPosition)
        $script:npmCommands | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', "npm: $_")
        }
    }
}

# Docker Completer: Auto-types docker commands
if (Get-Command docker -ErrorAction SilentlyContinue) {
    $script:dockerCommands = @('ps', 'run', 'exec', 'build', 'compose', 'logs', 'stop', 'start', 'restart', 'pull', 'push', 'images', 'rm', 'rmi')
    Register-ArgumentCompleter -Native -CommandName docker -ScriptBlock {
        param($wordToComplete, $commandAst, $cursorPosition)
        $script:dockerCommands | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', "docker: $_")
        }
    }
}

# ------------------------------------------------------------------------------
# 4. Prompt: Oh My Posh / Starship / Native Catppuccin Prompt
# ------------------------------------------------------------------------------
if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
    oh-my-posh init pwsh | Invoke-Expression
} elseif (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
} else {
    function prompt {
        $esc = [char]27
        $lastSuccess = $?

        # Git branch and status indicator (fast check using JetBrains Mono branch icon)
        $gitInfo = ""
        try {
            $branch = git branch --show-current 2>$null
            if ($branch) {
                $status = git status --porcelain 2>$null
                $dirty = if ($status) { " *" } else { "" }
                $branchIcon = [char]0xE0A0
                $gitInfo = " $esc[38;2;245;194;231m($branchIcon $branch$dirty)$esc[0m"
            }
        } catch {}

        # Shorten path (~ for home directory)
        $currPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path
        if ($currPath.StartsWith($HOME, [System.StringComparison]::OrdinalIgnoreCase)) {
            $currPath = "~" + $currPath.Substring($HOME.Length)
        }

        # Status symbol: [char]0x276F is ❯ (Green on Success, Red on Error)
        $arrow = [char]0x276F
        $symColor = if ($lastSuccess) { "$esc[38;2;166;227;161m" } else { "$esc[38;2;243;139;168m" }
        
        # Path color (Sky Blue)
        $pathColor = "$esc[38;2;137;220;235m"

        # Elevated Administrator badge
        $adminBadge = ""
        $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
        $principal = [Security.Principal.WindowsPrincipal]$identity
        if ($principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
            $adminBadge = "$esc[38;2;249;226;175m[ADMIN]$esc[0m "
        }

        "$adminBadge$pathColor$currPath$esc[0m$gitInfo $symColor$arrow$esc[0m "
    }
}

# ------------------------------------------------------------------------------
# 5. Directory Listing & File Inspection
# ------------------------------------------------------------------------------
if (Get-Command eza -ErrorAction SilentlyContinue) {
    function ll { eza -la --icons --git @args }
    function l  { eza --icons @args }
    function lt { eza --tree --level=2 --icons @args }
} elseif (Get-Command lsd -ErrorAction SilentlyContinue) {
    function ll { lsd -la @args }
    function l  { lsd @args }
    function lt { lsd --tree --depth=2 @args }
} else {
    function ll { Get-ChildItem -Path (if ($args) { $args } else { "." }) -Force | Format-Table Mode, Length, LastWriteTime, Name -AutoSize }
    function l  { Get-ChildItem -Path (if ($args) { $args } else { "." }) | Format-Table Mode, Length, LastWriteTime, Name -AutoSize }
}

# ------------------------------------------------------------------------------
# 6. Navigation Shortcuts
# ------------------------------------------------------------------------------
function ..    { Set-Location .. }
function ...   { Set-Location ../.. }
function ....  { Set-Location ../../.. }
function ..... { Set-Location ../../../.. }

# Make directory and cd into it in one command
function mkcd {
    param([Parameter(Mandatory=$true)][string]$Path)
    New-Item -ItemType Directory -Path $Path -Force | Out-Null
    Set-Location $Path
}

# ------------------------------------------------------------------------------
# 7. Developer Utilities & System Helpers
# ------------------------------------------------------------------------------

# Locate executable path like Linux 'which'
function which {
    param([Parameter(Mandatory=$true)][string]$Name)
    Get-Command $Name -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source -ErrorAction SilentlyContinue
}

# Create empty file or update timestamp like Linux 'touch'
function touch {
    param([Parameter(Mandatory=$true, ValueFromRemainingArguments=$true)][string[]]$Paths)
    foreach ($p in $Paths) {
        if (Test-Path $p) {
            (Get-Item $p).LastWriteTime = Get-Date
        } else {
            New-Item -ItemType File -Path $p -Force | Out-Null
        }
    }
}

# Open file or directory in Windows File Explorer / default handler
function open {
    param([string]$Path = ".")
    Invoke-Item $Path
}

# Fast recursive file finder
function ff {
    param([Parameter(Mandatory=$true)][string]$Name, [string]$Path = ".")
    Get-ChildItem -Path $Path -Filter "*$Name*" -Recurse -ErrorAction SilentlyContinue | Select-Object FullName
}

# Copy current path or specified path to clipboard
function copypath {
    param([string]$Path = ".")
    $resolved = (Resolve-Path $Path).Path
    Set-Clipboard -Value $resolved
    Write-Host "Copied to clipboard: $resolved" -ForegroundColor Green
}

# Show all active listening TCP ports
function listening-ports {
    Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue |
        Select-Object LocalAddress, LocalPort, OwningProcess |
        Sort-Object LocalPort
}
Set-Alias -Name ports -Value listening-ports -ErrorAction SilentlyContinue

# Quick process kill by name
function pskill {
    param([Parameter(Mandatory=$true)][string]$Name)
    Get-Process -Name "*$Name*" -ErrorAction SilentlyContinue | Stop-Process -Force -PassThru
}

# Grep alias (uses ripgrep if available, falls back to Select-String)
if (Get-Command rg -ErrorAction SilentlyContinue) {
    Set-Alias -Name grep -Value rg -ErrorAction SilentlyContinue
} else {
    function grep {
        param([Parameter(Mandatory=$true)][string]$Pattern, [string]$Path = "*")
        Select-String -Pattern $Pattern -Path $Path
    }
}

# Virtual environment activator (.venv / venv / env)
function venv-activate {
    $candidates = @(
        ".venv\Scripts\Activate.ps1",
        "venv\Scripts\Activate.ps1",
        "env\Scripts\Activate.ps1",
        "..\.venv\Scripts\Activate.ps1",
        "..\venv\Scripts\Activate.ps1"
    )
    foreach ($c in $candidates) {
        if (Test-Path $c) {
            & $c
            Write-Host "Activated virtual environment: $c" -ForegroundColor Green
            return
        }
    }
    Write-Warning "No virtual environment (.venv, venv, env) found in current directory."
}
Set-Alias -Name activate -Value venv-activate -ErrorAction SilentlyContinue

# Profile management shortcuts
function reload-profile {
    & $PROFILE
    Write-Host "Profile reloaded successfully!" -ForegroundColor Green
}
Set-Alias -Name reload -Value reload-profile -ErrorAction SilentlyContinue

function edit-profile {
    if (Get-Command code -ErrorAction SilentlyContinue) {
        code $PROFILE
    } elseif (Get-Command notepad -ErrorAction SilentlyContinue) {
        notepad $PROFILE
    } else {
        $PROFILE
    }
}
Set-Alias -Name ep -Value edit-profile -ErrorAction SilentlyContinue

# Relaunch current session with elevated Administrator privileges
function admin {
    if (Get-Command wt -ErrorAction SilentlyContinue) {
        Start-Process wt -ArgumentList "-d `"$PWD`"" -Verb RunAs
    } else {
        Start-Process powershell -ArgumentList "-NoExit -Command Set-Location '$PWD'" -Verb RunAs
    }
}

# ------------------------------------------------------------------------------
# 8. Git Convenience Shortcuts
# ------------------------------------------------------------------------------
if (Get-Command git -ErrorAction SilentlyContinue) {
    function gs  { git status --short --branch }
    function ga  { git add @args }
    function gaa { git add --all }
    function gc  { git commit @args }
    function gcm { git commit -m @args }
    function gp  { git push @args }
    function gpl { git pull @args }
    function gl  { git log --oneline --graph --decorate -n 15 }
    function gd  { git diff @args }
    function gco { git checkout @args }
    function gb  { git branch @args }
}

# ------------------------------------------------------------------------------
# 9. Auto-Correction Engine (Common Typos & CommandNotFoundAction)
# ------------------------------------------------------------------------------

# Direct typo wrappers for instant execution without error
function cd..   { Set-Location .. }
function cd/    { Set-Location \ }
function cd\    { Set-Location \ }
function dc     { Set-Location @args }
function claer  { Clear-Host }
function clr    { Clear-Host }
function pyhton { python @args }
function pythno { python @args }
function npn    { npm @args }
function coce   { code @args }

# Smart dynamic auto-correction hook for mistyped commands
$ExecutionContext.InvokeCommand.CommandNotFoundAction = {
    param($commandName, $eventArgs)

    $typoMap = @{
        'gti'       = 'git'
        'gut'       = 'git'
        'got'       = 'git'
        'gi'        = 'git'
        'claer'     = 'clear'
        'clea'      = 'clear'
        'clr'       = 'clear'
        'pyhton'    = 'python'
        'pythno'    = 'python'
        'npn'       = 'npm'
        'coce'      = 'code'
        'cdoe'      = 'code'
        'fastfech'  = 'fastfetch'
        'fatsfetch' = 'fastfetch'
        'pwsh7'     = 'pwsh'
    }

    $cmdLower = $commandName.ToLower()
    if ($typoMap.ContainsKey($cmdLower)) {
        $target = $typoMap[$cmdLower]
        $cmd = Get-Command $target -ErrorAction SilentlyContinue
        if ($cmd) {
            $esc = [char]27
            Write-Host "$esc[38;2;250;179;135m[Auto-Correct]$esc[0m Running '$target' instead of '$commandName'..." -ForegroundColor Yellow
            $eventArgs.Command = $cmd
        }
    }
}
