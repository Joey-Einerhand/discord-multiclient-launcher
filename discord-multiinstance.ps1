# How to use:
# Pin this script to your task bar 
# (Drag and drop it in your task bar -> Right click -> Pin to taskbar)
# Click on the script when you want to run a new instance of Discord.

# This script assumes Discord is installed under the current windows user. 

# DISKLETTER:\Users\USERNAME\AppData\Local\Discord
$discordPath = Join-Path -Path $env:LOCALAPPDATA -ChildPath "Discord"

# Whenever Discord updates, another folder is added with the following syntax:
# app-VERSION, i.e. app-1.0.9045, app-1.0.9157, etc
# To get Discord to run multiple times with different accounts,
# We need to get the most recent app version, go into that folder,
# run `Discord.exe` with the parameter `--multi-instance`

function Main {
    $latestVersionPath = Get-DiscordLatestVersionPath $discordPath
    $discordExePath = Join-Path -Path $latestVersionPath -ChildPath "Discord.exe"
    Start-DiscordMultiInstance $discordExePath
}

function Get-DiscordLatestVersionPath {
    param (
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$discordPath
    )

    # Array of all the app-VERSION folders, assumed to be unsorted
    $versionFolders = Get-ChildItem -Path (Join-Path -Path $discordPath -ChildPath "app-*") -directory -Name

    $latestVersionFolder = $versionFolders | Sort-Object -Descending | Select-Object -First 1

    if (-not $latestVersionFolder) {
        throw "No discord version folders found in $discordPath"
    }

    $latestVersionFolderPath = Join-Path -Path $DiscordPath -ChildPath $latestVersionFolder

    return $latestVersionFolderPath 
}

function Start-DiscordMultiInstance {
    param (
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$pathToExe
    )

    $exeExists = Test-Path $pathToExe

    if ($exeExists) {
        Start-Process -FilePath $pathToExe -ArgumentList "--multi-instance"
    }
    else {
        throw "No discord EXE found at location $pathToExe"
    }
}

Main
