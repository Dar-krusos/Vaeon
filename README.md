# Vaeon
A rounded, minimalist custom-client-Discord theme designed to be color-agnostic to synergise with rotating backgrounds.

## Installation
Simply download and place `Vaeon.theme.css` into your client's `\themes` folder, e.g. `%appdata%\betterdiscord\themes` for BetterDiscord.

## Customisation
The main customisation options for this theme are in the `Vaeon.theme.css` file, but you can really add or change anything you want. There may be some things tagged by the remote import file (`Vaeon-main.theme.css`) as `!important`, in which case you must also use this at the end of relevant css lines.

### Alternate styling option
You can also download and place `Vaeon-alt-addon.theme.css` in `\themes` for an alternate opacity style.

## Rotating background
If you can't find a way to do this otherwise, you can use [the provided Powershell 7 script](https://github.com/Dar-krusos/Vaeon/tree/main/scripts) to automate changing of your desktop and Vaeon background so that they are always synced. You must [install Powershell 7](https://learn.microsoft.com/en-us/powershell/scripting/install/install-powershell-on-windows). Powershell blocks foreign scripts by default, so you should manually use `pwsh.exe -ExecutionPolicy Bypass -File "path\to\wallpaper.ps1"` to run it. You can automate scheduled execution of this command in Window's Task Scheduler:
- Triggers: whatever you like
- Action: Start a program
- - Program/script: pwsh.exe
- - Add arguments: -ExecutionPolicy Bypass -File "path\to\wallpaper.ps1"

---
### Disclaimer
I don't use Discord too much anymore, so there may be things I haven't themed/updated. Just open an [issue](https://github.com/Dar-krusos/discord-theme-vaeon/issues) and I'll try my best to get to it.