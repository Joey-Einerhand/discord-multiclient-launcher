# How to use:
# Pin this script to your task bar
# (Drag and drop it in your task bar -> Right click -> Pin to taskbar)
# Click on the script when you want to run a new instance of Discord.

# This script assumes Discord is installed under the current windows user. 

function Main {
    Start-DiscordMultiInstance
}

function Start-DiscordMultiInstance {
    # DISKLETTER:\Users\USERNAME\AppData\Local\Discord
    $discordLaunchExe = Join-Path -Path $env:LOCALAPPDATA -ChildPath "Discord\Update.exe"
    $pathToProfiles = Join-Path -Path $env:LOCALAPPDATA -ChildPath "Discord\profiles"

    if (-Not (Test-Path $pathToProfiles)) {
        New-Item -ItemType Directory -Path $pathToProfiles
    }

    # count running UI instances of discord
    $discordsActive = @(Get-Process discord -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowHandle -ne 0 }).Count
    $nextDiscordIndex = $discordsActive + 1
    # This starts profiles at either 1 or 2 depending on if the user runs one discord user the default way without this script
    $profilePathToUse = Join-Path -Path $env:LOCALAPPDATA -ChildPath "Discord\profiles\alt$nextDiscordIndex"
    # Clean up previous profile paths
    while (Test-Path $profilePathToUse) {
        # Sometimes, previously used profile paths might still be in use,
        # even if the corresponding discord processes are closed.
        # So, try to delete the profile path. If that's not possible, try the next index
        try {
            Remove-Item -Path $profilePathToUse -Recurse -Force -ErrorAction Stop 2>$null
        }
        catch {
            $nextDiscordIndex += 1
            $profilePathToUse = Join-Path -Path $env:LOCALAPPDATA -ChildPath "Discord\profiles\alt$nextDiscordIndex"
        }
    }
    New-Item -ItemType Directory -Path $profilePathToUse

    $env:DISCORD_USER_DATA_DIR = $profilePathToUse
    Start-Process $discordLaunchExe -ArgumentList '--processStart Discord.exe --process-start-args "--multi-instance"'
}

Main
