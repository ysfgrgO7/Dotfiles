# Helper: Check command and install if missing
function Ensure-Command {
    param (
        [string]$Command,
        [string]$WingetPackage
    )
    if (-not (Get-Command $Command -ErrorAction SilentlyContinue)) {
        Write-Host "⚠️ $Command not found. Installing..." -ForegroundColor Yellow
        winget install --id $WingetPackage --silent
    }
}

# Check essential apps
Ensure-Command lsd "LSDeluxe.lsd"

# Replace default ls with lsd (fancy ls replacement)
if (Get-Command lsd -ErrorAction SilentlyContinue) {
    Remove-Item Alias:ls -ErrorAction SilentlyContinue
    function ls { lsd -la --color always @args }
    function ll { lsd -lh --color always @args }
    function lt { lsd --tree --color always @args }
} else {
    Write-Host "⚠️ lsd not found, using default ls" -ForegroundColor Yellow
}

# Common GNU-like Aliases
Set-Alias rm Remove-Item
Set-Alias cp Copy-Item -Option AllScope
Set-Alias mv Move-Item
Set-Alias cat Get-Content
Set-Alias touch New-Item
Set-Alias grep Select-String
Set-Alias clear Clear-Host
Set-Alias pwd Get-Location

# Quick Navigation
function .. { Set-Location .. }
function ... { Set-Location ../.. }
function .... { Set-Location ../../.. }

### PSReadLine Enhancements (Fish/Zsh-like experience) ###
if (-not (Get-Module -ListAvailable -Name PSReadLine)) {
    Write-Host "⚠️ PSReadLine module missing. Installing..." -ForegroundColor Yellow
    Install-Module PSReadLine -Force -Scope CurrentUser
}

Import-Module PSReadLine -ErrorAction SilentlyContinue
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineOption -BellStyle None

# Tab-style completion
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key "Shift+Tab" -Function TabCompletePrevious

### CompletionPredictor ###
if (-not (Get-Module -ListAvailable -Name CompletionPredictor)) {
    Write-Host "⚠️ CompletionPredictor module missing. Installing..." -ForegroundColor Yellow
    Install-Module CompletionPredictor -Force -Scope CurrentUser
}

Import-Module CompletionPredictor -ErrorAction SilentlyContinue

# Enable Predictive Suggestions
Set-PSReadLineOption -PredictionSource HistoryAndPlugin

function Prompt {
    $origDollarQuestion = $global:?
    $esc = [char]27
    $user = [System.Environment]::UserName
    $hostName = $env:COMPUTERNAME.ToLower()
    $cwdFull = (Get-Location).Path
    if ($cwdFull -eq $HOME) {
        $cwd = "~"
    } else {
        $cwd = Split-Path $cwdFull -Leaf
    }
    if ($origDollarQuestion) {
        $promptArrow = " $esc[1;32m➜$esc[0m " # Green
    } else {
        $promptArrow = " $esc[1;31m➜$esc[0m " # Red
    }
    $open = "$esc[1;34m[$esc[0m"
    $close = "$esc[1;34m]$esc[0m"
    $promptUserHost = "$esc[1;37m$user$esc[1;31m@$esc[1;37m$hostName$esc[0m"
    $promptPath = "$esc[1;34m$cwd$esc[0m"
    $returnPrompt = "$open$promptUserHost$close$promptArrow$promptPath "
    $returnPrompt
    if ($global:? -ne $origDollarQuestion) {
        if ($origDollarQuestion) {
            1+1
        } else {
            Write-Error '' -ErrorAction 'Ignore' # Sets $? to False and prevents error from being added to $Error collection
        }
    }
}
