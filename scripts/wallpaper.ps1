$logs="place\to\put\logs"
$css="$env:APPDATA\Roaming\BetterDiscord\themes\Vaeon.theme.css"

$files = Get-ChildItem -Path "path\to\image(s)" -File -Recurse

# get list of used images
if (-not (Test-Path $logs\history.txt)) {
    New-Item $logFile -ItemType File | Out-Null
}

$used = [System.Collections.Generic.HashSet[string]]::new()

Get-Content $logs\history.txt | ForEach-Object {
    if ($_ -match '\|\s(.*)\s\|') {
        $name = $matches[1].Trim()
        $used.Add($name) | Out-Null
    }
}

# consolidate list of fresh images
$available = $files | Where-Object { -not $used.Contains($_.BaseName) }

# reset if all used
if ($available.Count -eq 0) {
    Clear-Content $logs\log.txt
    Clear-Content $logs\history.txt
    $available = $files
}

# get random image from list
$image = Get-Random -InputObject $available

# upload to catbox
try {
    $url = Invoke-RestMethod `
        -Uri "https://catbox.moe/user/api.php" `
        -Method Post `
        -TimeoutSec 30 `
        -Form @{
            reqtype      = "fileupload"
            fileToUpload = Get-Item "$image"
        }
}
catch {
    $url = $url -replace "`r?`n", "`n$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') | "
    $logError = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') | Failed to upload:`n `
    $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') | $url`n `
    $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') | Exit code $?."
}

# update theme css
(Get-Content $css) -replace '--background-url: url\(".*?"\)', "--background-url: url(`"$url`")" | Set-Content $css

# change wallpaper
Add-Type @"
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@
[Wallpaper]::SystemParametersInfo(20, 0, $image, 3)

# log entry
$imageFullname = $image.BaseName
$imageName = "$imageFullname" -replace '\.[^.]+$'
$logImage = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') | $imageName | $url"
Add-Content $logs\log.txt $logImage
Add-Content $logs\history.txt $logImage