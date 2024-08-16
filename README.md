# discord-multiinstance-launcher
Easily launch multiple instances of Discord for multiple accounts, without the hassle of creating a new shortcut each time Discord updates.

Based off of this [reddit thread](https://www.reddit.com/r/discordapp/comments/kk6rp7/how_to_actually_easily_multiclient/).

The reddit thread suggests creating a shortcut and editing the Target to launch Discord as multi-client. However, this shortcut gets removed each time Discord updates, after which you have to follow the process all over again.
This repo contains the PowerShell script (and exe) used for launching the latest Discord client in multi-instance mode, automatically targetting the latest Discord update on your device. No more messing around with shortcuts.

## How to use:

### Windows:
1. Go to the [releases page](https://github.com/Joey-Einerhand/discord-multiinstance-launcher/releases) and download the .exe
2. Move it somewhere you won't delete, for example on your desktop
3. Start the .exe by double-clicking on it.
4. Optional: Pin it to your taskbar for easy access.

### Linux, MacOS
It doesn't work out of the box. I didn't create this for Linux or MacOS. However, assuming the Discord Installation folder structure is the same on Linux and MacOS as on Windows, this is how you'd adapt my script to (maybe) work:
1. Install Powershell on [Linux](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-linux?view=powershell-7.4) or on [MacOS](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-macos?view=powershell-7.4)
2. Edit the contents of `discord-multiinstance.ps1`. On line 9, replace `$env:LOCALAPPDATA` with the path to your equivalent of the Discord folder in Windows' `DISKLETTER:\Users\USERNAME\AppData\Local\Discord`. The Discord folder should have sub-folders like `app-VERSION`, for example `app-1.0.9045`, or `app-1.0.9157`, etc.
3. Run the script

