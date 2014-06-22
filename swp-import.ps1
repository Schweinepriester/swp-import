param(
[string]$path
)
#Write-Host $path

function Show-BalloonTip {            
[cmdletbinding()]            
param(            
 [parameter(Mandatory=$true)]            
 [string]$Title,            
 [ValidateSet("Info","Warning","Error")]             
 [string]$MessageType = "Info",            
 [parameter(Mandatory=$true)]            
 [string]$Message,            
 [string]$Duration=10000            
)            

[system.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | Out-Null            
$balloon = New-Object System.Windows.Forms.NotifyIcon            
$path = Get-Process -id $pid | Select-Object -ExpandProperty Path            
$icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)            
$balloon.Icon = $icon            
$balloon.BalloonTipIcon = $MessageType            
$balloon.BalloonTipText = $Message            
$balloon.BalloonTipTitle = $Title            
$balloon.Visible = $true            
$balloon.ShowBalloonTip($Duration)            
}

C:\Python27\Scripts\beet.exe import $path
$pathToCover = $path + "\cover.jpg"
Remove-Item $pathToCover 

$itunes = New-Object -ComObject iTunes.Application
$tracks = $itunes.LibraryPlaylist
$add = $tracks.AddFile($path)

$ballonMessage = "'" + $path + "' importiert!"
Show-BalloonTip -Title “Import erfolgreich!” -MessageType Info -Message $ballonMessage -Duration 1000