# The Boys Fika Co-Op Server - Client Update Script
# Author: Codsworth
# Last Updated: 05-17-2024
# Version 0.4

#create variables
$update = "https://github.com/Vault95/BrainPower/releases/download/TheBoysServerPack/Update1.0.zip"
$serverpackVersion = 1.2 # !!! MUST CHANGE THIS ON EACH UPDATE !!!
Write-Host "Current Live ServerPack Version: $serverpackVersion"
$localserverpackVersion = [IO.File]::ReadAllText("$PSScriptRoot\serverpackVersion.txt")
Write-Host "Currently Installed ServerPack Version: $localserverpackVersion"
Start-Sleep -Seconds 5
if ($serverpackVersion -eq $localserverpackVersion)
{
Add-Type -AssemblyName PresentationCore,PresentationFramework
$answer1 = [System.Windows.MessageBox]::Show("Server Pack $serverpackVersion has already been installed. Would you like to force update? Note: Force updating will reconfigure some updated mods. It may or may not fix issues. Re-installing using the Setup.bat or contact Codsworth if Force Update does not resolve issues. ",'Force Update?','YesNo','Question')
switch ($answer1)
{
	'Yes'
	{
		#Download BrainPower zip file from github to current directory
try {
	$ProgressPreference = 'SilentlyContinue'
	Write-Host "Downloading..."
    Invoke-WebRequest -Uri $update -OutFile $PSScriptRoot\Update.zip
} catch {
    # This will just write the error
    Write-Host "Download failed. Yell at Codsworth. Error: $_"
    # If you want to pass the error upwards as a system error and abort your powershell script or function
    Throw "Download failed. Yess at Codsworth. Error: $_"
	Start-Sleep -Seconds 5
}
Write-Host "Download Complete."
Write-Host "Installing Update."
try {
	#!!! 1.1 -> 1.2 UPDATE ONLY !!!
	#Delete questbots config file
	$questbotsConfig = Test-Path -Path $PSScriptRoot\BepInEx\config\com.DanW.QuestingBots.cfg
	If ($questbotsConfig -eq "True")
	{
		Remove-Item $PSScriptRoot\BepInEx\config\com.DanW.QuestingBots.cfg
		Write-Host "Removing Questing Bots config file for update"
	} else {
		Write-Host "QuestBots config file not found... continuing"
	}
	Start-Sleep -Seconds 1
	#Delete SAIN config file
	$sainConfig = Test-Path -Path $PSScriptRoot\BepInEx\config\me.sol.sain.cfg
	If ($sainConfig -eq "True")
	{
		Remove-Item $PSScriptRoot\BepInEx\config\me.sol.sain.cfg
		Write-Host "Removing SAIN config file for update"
	} else {
		Write-Host "SAIN config file not found... continuing"
	}
	Start-Sleep -Seconds 1
	#Delete fika config file
	$fikaConfig = Test-Path -Path $PSScriptRoot\BepInEx\config\com.fika.core.cfg
	If ($fikaConfig -eq "True")
	{
		Remove-Item $PSScriptRoot\BepInEx\config\com.fika.core.cfg
		Write-Host "Removing FIKA config file for update"
	} else {
		Write-Host "FIKA config file not found...what did you do nerd... continuing to attempt to fix"
	}
	Start-Sleep -Seconds 1
	#delete wtt long lost heads.dll
	$wttVoice = Test-Path -Path $PSScriptRoot\BepInEx\plugins\WTT-RogueJusticeVoiceAdder.dll
	If ($wttVoice -eq "True")
	{
		Remove-Item $PSScriptRoot\BepInEx\plugins\WTT-RogueJusticeVoiceAdder.dll
		Write-Host "Removing WTT files for update"
	} else {
		Write-Host "WTT File already removed... continuing"
	}
	Start-Sleep -Seconds 1
	#delete user/mods/WTT folders
	$wttFolders = Test-Path -Path $PSScriptRoot\user\mods
	If ($wttFolders -eq "True")
	{
		Remove-Item -Recurse -Force $PSScriptRoot\user\mods
		Write-Host "Removing unnecessary WTT files"
	} else {
		Write-Host "User mods folder looks good moving on..."
	}
	#remove sain folder for reinstall
	$sainFolder = Test-Path -Path $PSScriptRoot\BepInEx\plugins\SAIN
	If ($sainFolder -eq "True")
	{
		Remove-Item -Recurse -Force $PSScriptRoot\BepInEx\plugins\SAIN
		Write-Host "Removing SAIN for re-install"
	} else {
		Write-Host "No SAIN folder found... the fuck did you do.... attempting to fix"
	}
	#delete boss notifier mod
	$bossNotifier = Test-Path -Path $PSScriptRoot\BepInEx\plugins\BossNotifier.dll
	If ($bossNotifier -eq "True")
	{
		Remove-Item $PSScriptRoot\BepInEx\plugins\BossNotifier.dll
		Write-Host "Deleting Boss Notifier mod"
	} else {
		Write-Host "Boss notifier mod already removed... GOOD BOY"
	}
	Start-Sleep -Seconds 1
	#delete door randomizer.dll
	$doorRandomizer = Test-Path -Path $PSScriptRoot\BepInEx\plugins\DrakiaXYZ-DoorRandomizer.dll
	If ($doorRandomizer -eq "True")
	{
		Remove-Item $PSScriptRoot\BepInEx\plugins\DrakiaXYZ-DoorRandomizer.dll
		Write-Host "Deleted dog shit Door Randomizer mod"
	} else {
		Write-Host "No door randomizer mod found to remove, continuing..."
	}
	Start-Sleep -Seconds 1
	#delete voice adder DLL WTT
	$rogueJustice = Test-Path -Path $PSScriptRoot\BepInEx\plugins\WTT-RogueJusticeVoiceAdder.dll
	If ($rogueJustice -eq "True")
	{
		Remove-Item $PSScriptRoot\BepInEx\plugins\WTT-RogueJusticeVoiceAdder.dll
		Write-Host "Patching the Punisher Boss mod to hopefully fix it"
	} else {
		Write-Host "File already removed... continuing"
	}
	Start-Sleep -Seconds 1
	
	$ProgressPreference = 'SilentlyContinue'
	Expand-Archive -Path Update.zip -DestinationPath $PSScriptRoot -Force
} catch {
    # This will just write the error
    Write-Host "Download failed. Yess at Codsworth. Error: $_"
    # If you want to pass the error upwards as a system error and abort your powershell script or function
    Throw "Install failed. Yell at Codsworth. Error: $_"
	Start-Sleep -Seconds 5
}
Start-Sleep -Seconds 5
#delete update.zip file if exists
	$updateFolder = Test-Path -Path $PSScriptRoot\Update.zip
	If ($updateFolder -eq "True")
	{
		Remove-Item -Recurse -Force $PSScriptRoot\Update.zip
		Write-Host "Removing setup files"
	} else {
		Write-Host "No setup files found to remove. All done!"
	}
[System.Windows.MessageBox]::Show("Update to Server Pack $serverpackVersion has been completed.",'THE BOYS')
	} # end yes
	'No'
	{ 
		exit
		Return "Runs Nothing"
	} # end no
} #end switch
}

if ($serverpackVersion -ne $localserverpackVersion)
{

	Write-Host "Downloading update files..."

#Download BrainPower zip file from github to current directory
try {
	$ProgressPreference = 'SilentlyContinue'
	Write-Host "Downloading..."
    Invoke-WebRequest -Uri $update -OutFile $PSScriptRoot\Update.zip
} catch {
    # This will just write the error
    Write-Host "Download failed. Yell at Codsworth. Error: $_"
    # If you want to pass the error upwards as a system error and abort your powershell script or function
    Throw "Download failed. Yess at Codsworth. Error: $_"
	Start-Sleep -Seconds 5
}
Write-Host "Download Complete."
#!!! 1.1 -> 1.2 UPDATE ONLY !!!
	#Delete questbots config file
	$questbotsConfig = Test-Path -Path $PSScriptRoot\BepInEx\config\com.DanW.QuestingBots.cfg
	If ($questbotsConfig -eq "True")
	{
		Remove-Item $PSScriptRoot\BepInEx\config\com.DanW.QuestingBots.cfg
		Write-Host "Removing Questing Bots config file for update"
	} else {
		Write-Host "QuestBots config file not found... continuing"
	}
	#Delete SAIN config file
	$sainConfig = Test-Path -Path $PSScriptRoot\BepInEx\config\me.sol.sain.cfg
	If ($sainConfig -eq "True")
	{
		Remove-Item $PSScriptRoot\BepInEx\config\me.sol.sain.cfg
		Write-Host "Removing SAIN config file for update"
	} else {
		Write-Host "SAIN config file not found... continuing"
	}
	#Delete fika config file
	$fikaConfig = Test-Path -Path $PSScriptRoot\BepInEx\config\com.fika.core.cfg
	If ($fikaConfig -eq "True")
	{
		Remove-Item $PSScriptRoot\BepInEx\config\com.fika.core.cfg
		Write-Host "Removing FIKA config file for update"
	} else {
		Write-Host "FIKA config file not found...what did you do nerd... continuing to attempt to fix"
	}
	#delete wtt long lost heads.dll
	$wttLong = Test-Path -Path $PSScriptRoot\BepInEx\plugins\WTT-TheLongLostHeadsOfYojenkz.dll
	If ($wttLong -eq "True")
	{
		Remove-Item $PSScriptRoot\BepInEx\plugins\WTT-TheLongLostHeadsOfYojenkz.dll
		Write-Host "Removing  WTT files for update"
	} else {
		Write-Host "No cleaning of WTT Long lost mod needed... continuing"
	}
	#delete user/mods/WTT folders
	$wttFolders = Test-Path -Path $PSScriptRoot\user\mods
	If ($wttFolders -eq "True")
	{
		Remove-Item -Recurse -Force $PSScriptRoot\user\mods
		Write-Host "Removing unnecessary WTT files"
	} else {
		Write-Host "User mods folder looks good moving on..."
	}
	#delete door randomizer.dll
	$doorRandomizer = Test-Path -Path $PSScriptRoot\BepInEx\plugins\DrakiaXYZ-DoorRandomizer.dll
	If ($doorRandomizer -eq "True")
	{
		Remove-Item $PSScriptRoot\BepInEx\plugins\DrakiaXYZ-DoorRandomizer.dll
		Write-Host "Deleted dog shit Door Randomizer mod"
	} else {
		Write-Host "No door randomizer mod found to remove, continuing..."
	}
	#delete voice adder DLL WTT
	$rogueJustice = Test-Path -Path $PSScriptRoot\BepInEx\plugins\WTT-RogueJusticeVoiceAdder.dll
	If ($rogueJustice -eq "True")
	{
		Remove-Item $PSScriptRoot\BepInEx\plugins\WTT-RogueJusticeVoiceAdder.dll
		Write-Host "Patching the Punisher Boss mod to hopefully fix it"
	} else {
		Write-Host "File already removed... continuing"
	}
	#delete boss notifier mod
	$bossNotifier = Test-Path -Path $PSScriptRoot\BepInEx\plugins\BossNotifier.dll
	If ($bossNotifier -eq "True")
	{
		Remove-Item $PSScriptRoot\BepInEx\plugins\BossNotifier.dll
		Write-Host "Deleting Boss Notifier mod"
	} else {
		Write-Host "Boss notifier mod already removed... GOOD BOY"
	}
	Start-Sleep -Seconds 2
		#remove sain folder for reinstall
	$sainFolder = Test-Path -Path $PSScriptRoot\BepInEx\plugins\SAIN
	If ($sainFolder -eq "True")
	{
		Remove-Item -Recurse -Force $PSScriptRoot\BepInEx\plugins\SAIN
		Write-Host "Removing SAIN for re-install"
	} else {
		Write-Host "No SAIN folder found... the fuck did you do.... attempting to fix"
	}
	### END
Write-Host "Installing Update."
try {
	$ProgressPreference = 'SilentlyContinue'
	Expand-Archive -Path Update.zip -DestinationPath $PSScriptRoot -Force
} catch {
    # This will just write the error
    Write-Host "Download failed. Yell at Codsworth. Error: $_"
    # If you want to pass the error upwards as a system error and abort your powershell script or function
    Throw "Install failed. Yell at Codsworth. Error: $_"
	Start-Sleep -Seconds 5
}
#delete update.zip file if exists
	$updateFolder = Test-Path -Path $PSScriptRoot\Update.zip
	If ($updateFolder -eq "True")
	{
		Remove-Item -Recurse -Force $PSScriptRoot\Update.zip
		Write-Host "Removing setup files"
	} else {
		Write-Host "No setup files found to remove. All done!"
	}
[System.Windows.MessageBox]::Show("Update to Server Pack $serverpackVersion has been completed.",'THE BOYS')
} # end if statement version not equal






 
