# The Boys Fika Co-Op Server - Client Update Script
# Author: Codsworth
# Last Updated: 05-22-2024
# Version 0.6 #!!! MUST CHANGE THIS ON EACH UPDATE!!!

$serverpackVersion = 1.3 # !!! MUST CHANGE THIS ON EACH UPDATE !!!

write-host 
"
##############################################################
#                                                            #
#                   Codsworth's Updater                      #
#                         v 0.6                              #
##############################################################
#                   The Boys Server Pack $serverpackVersion                 #
#                                                            #
#                   Updated: 05/21/2024                      #
#                                                            #
##############################################################
"
 #End intro

$update = "https://github.com/Vault95/BrainPower/releases/download/tarkov/Update1.3.zip"

Write-Host "Current Live ServerPack Version: $serverpackVersion"

$localserverpackVersion = [IO.File]::ReadAllText("$PSScriptRoot\serverpackVersion.txt")

Write-Host "Currently Installed ServerPack Version: $localserverpackVersion"
Start-Sleep -Seconds 2
Add-Type -AssemblyName PresentationCore,PresentationFramework
if ($serverpackVersion -eq $localserverpackVersion)
{
Write-Host "Game is up to date!" -ForegroundColor green
Write-Host "Running launcher... prepare for death by snoo snoo" -ForegroundColor cyan
Start-Sleep -Seconds 1
Start-Process -FilePath $PSScriptRoot\Aki.Launcher.exe
}

if ($serverpackVersion -ne $localserverpackVersion)
{
	Write-Host "Update found." -ForegroundColor yellow
	Write-Host "Downloading update files..." -ForegroundColor yellow

try {
#Download BrainPower zip file from github to current directory
	$ProgressPreference = 'SilentlyContinue'
	Write-Host "Downloading..."
    Invoke-WebRequest -Uri $update -OutFile $PSScriptRoot\Update.zip

Write-Host "Download Complete."
Write-Host "Cleaning files..." -ForegroundColor yellow

Start-Sleep -Seconds 1
	#delete wtt long lost heads.dll
	$wttVoice = Test-Path -Path $PSScriptRoot\BepInEx\plugins\WTT-RogueJusticeVoiceAdder.dll
	If ($wttVoice -eq "True")
	{
		Remove-Item -Recurse -Force $PSScriptRoot\BepInEx\plugins\WTT-RogueJusticeVoiceAdder.dll
	}
	#delete user/mods/WTT folders
	$wttFolders = Test-Path -Path $PSScriptRoot\user\mods
	If ($wttFolders -eq "True")
	{
		Remove-Item -Recurse -Force $PSScriptRoot\user\mods
	}
	#remove sain folder for reinstall
	$sainFolder = Test-Path -Path $PSScriptRoot\BepInEx\plugins\SAIN
	If ($sainFolder -eq "True")
	{
		Remove-Item -Recurse -Force $PSScriptRoot\BepInEx\plugins\SAIN
	} 
	#delete boss notifier mod
	$bossNotifier = Test-Path -Path $PSScriptRoot\BepInEx\plugins\BossNotifier.dll
	If ($bossNotifier -eq "True")
	{
		Remove-Item -Recurse -Force $PSScriptRoot\BepInEx\plugins\BossNotifier.dll
	}
	#delete door randomizer.dll
	$doorRandomizer = Test-Path -Path $PSScriptRoot\BepInEx\plugins\DrakiaXYZ-DoorRandomizer.dll
	If ($doorRandomizer -eq "True")
	{
		Remove-Item -Recurse -Force $PSScriptRoot\BepInEx\plugins\DrakiaXYZ-DoorRandomizer.dll
	}
	#delete voice adder DLL WTT
	$rogueJustice = Test-Path -Path $PSScriptRoot\BepInEx\plugins\WTT-RogueJusticeVoiceAdder.dll
	If ($rogueJustice -eq "True")
	{
		Remove-Item -Recurse -Force $PSScriptRoot\BepInEx\plugins\WTT-RogueJusticeVoiceAdder.dll
	}
	#delete questing bots dll
	$questBots = Test-Path -Path $PSScriptRoot\BepInEx\plugins\SPTQuestingBots.dll
	If ($questBots  -eq "True")
	{
		Remove-Item -Force $PSScriptRoot\BepInEx\plugins\SPTQuestingBots.dll
	}
	#delete WTT Up in Smoke DLL, not needed with new update
	$wttSmoke = Test-Path -Path $PSScriptRoot\BepInEx\plugins\WTT-UpInSmoke.dll
	If ($wttSmoke  -eq "True")
	{
		Remove-Item -Force $PSScriptRoot\BepInEx\plugins\WTT-UpInSmoke.dll
	}
	Write-Host "File cleanup completed." -ForegroundColor yellow
	Write-Host "Updating..." -ForegroundColor yellow
	$ProgressPreference = 'SilentlyContinue'
	Expand-Archive -Path Update.zip -DestinationPath $PSScriptRoot -Force
	Write-Host "Update completed... I hope..."
	Write-Host "Starting file cleanup"


#delete update.zip file if exists
	Write-Host "Removing update files..."
	$updateFolder = Test-Path -Path $PSScriptRoot\Update.zip
	If ($updateFolder -eq "True")
	{
		Remove-Item -Recurse -Force $PSScriptRoot\Update.zip
		Write-Host "Update files removed."
	}
	Write-Host "Updated to Server Pack $serverpackVersion successfully!" -ForegroundColor green
	Write-Host "Running launcher... prepare thy cheeks." -ForegroundColor cyan
	#Set local version file to new version
	Set-Content $PSScriptRoot\serverpackVersion.txt "$serverpackVersion"
	#Start launcher after updating
	} catch {
    # This will just write the error
    Write-Host "Download failed. Yess at Codsworth. Error: $_"
    # If you want to pass the error upwards as a system error and abort your powershell script or function
    Throw "Install failed. Yell at Codsworth. Error: $_"
} #end catch 
	Start-Sleep -Seconds 4
	Start-Process -FilePath $PSScriptRoot\Aki.Launcher.exe
} # end if statement version not equal







 
