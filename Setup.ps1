# The Boys Fika Co-Op Server Pack - Client Setup Script
# Author: Codsworth
# Last Updated: 05-22-2024
# Version 0.6

#create URL variable
$setup = "https://github.com/Vault95/BrainPower/releases/download/tarkov/Setup1.3.zip"

#Download BrainPower zip file from github to current directory
try {
	$ProgressPreference = 'SilentlyContinue'
	Write-Host "Downloading... Be patient lil bitch"
    Invoke-WebRequest -Uri $setup -OutFile $PSScriptRoot\Setup.zip
} catch {
    # Catch will pick up any non zero error code returned
    # You can do anything you like in this block to deal with the error, examples below:
    # $_ returns the error details
    # This will just write the error
    Write-Host "Download failed. Yell at Codsworth. Error: $_"
    # If you want to pass the error upwards as a system error and abort your powershell script or function
    Throw "Download failed. Yell at Codsworth. Error: $_"
	Start-Sleep -Seconds 5
}

Write-Host "Download Complete."

Expand-Archive -Path Setup.zip -DestinationPath $PSScriptRoot -Force
Write-Host "Extraction Complete."
Write-Host "Proceed with Runtime installation."
Write-Host "If Microsoft Runtime is already installed, you can cancel installation of Runtime and move on."
#Install Runtime 8.0

try {
    Start-Process -FilePath "runtime-8.0.2.exe" -wait
} catch {
    # Catch will pick up any non zero error code returned
    # You can do anything you like in this block to deal with the error, examples below:
    # $_ returns the error details
    # This will just write the error
    Write-Host "Microsoft Runtime 8.0 Install failed, ask Codsworth for help. Error: $_"
    # If you want to pass the error upwards as a system error and abort your powershell script or function
    Throw "Microsoft Runtime 8.0 Install failed, ask Codsworth for help. Error: $_"
	Start-Sleep -Seconds 5
}
Add-Type -AssemblyName PresentationCore,PresentationFramework
if ( $null -eq ('System.Windows.MessageBox' -as [type]) ) {
    Add-Type -AssemblyName PresentationFramework
}
$msgBoxInput =  [System.Windows.MessageBox]::Show(
    "Is Microsoft Runtime 8.0 installed?",
    'Confirm Update',
    'YesNo')
switch  ($msgBoxInput) 
      {
          'Yes' 
          {
            #Install SPT
Write-Host "Proceed with SPT installation."
Write-Host "SPT Installer Launching..."
try {
    Start-Process -FilePath "SPTInstaller.exe" -wait
} catch {
    # Catch will pick up any non zero error code returned
    # You can do anything you like in this block to deal with the error, examples below:
    # $_ returns the error details
    # This will just write the error
    Write-Host "SPT Install failed, please refer to the SPT Installer to resolve. Error: $_"
    # If you want to pass the error upwards as a system error and abort your powershell script or function
    Throw "SPT Install failed. Please refer to the launcher to resolve issues and re-run this file once resolve. Error: $_"
}

if ( $null -eq ('System.Windows.MessageBox' -as [type]) ) {
    Add-Type -AssemblyName PresentationFramework
}
$msgBoxInput =  [System.Windows.MessageBox]::Show(
    "Did SPT Install Correctly? Only press yes if SUCCESSFULLY INSTALLED",
    'Confirm Update',
    'YesNo')
switch  ($msgBoxInput) 
      {
          'Yes' 
          {
            
		#Extract modpack + config files for server, overwrite existing
Write-Host "Extracting ModPack."
Expand-Archive -Path NewInstall.zip -DestinationPath $PSScriptRoot -Force
Write-Host "Extraction complete."
Start-Sleep -Seconds 2
Write-Host "Running Firewall Fixer..."
#Run Firewall Fixer
try {
    Start-Process "FikaFirewallFixer.exe" -wait
} catch {
    # Catch will pick up any non zero error code returned
    # You can do anything you like in this block to deal with the error, examples below:
    # $_ returns the error details
    # This will just write the error
    Write-Host "Firewall Fix failed, ask Codsworth for help. Error: $_"
    # If you want to pass the error upwards as a system error and abort your powershell script or function
    Throw "Firewall Fix failed, ask Codsworth for help or try again. Error: $_"
}
Write-Host "If you did not install firewall fixer, you may have connection issues!!!."
Write-Host "Finishing up...."
Start-Sleep -Seconds 5
Add-Type -AssemblyName PresentationCore,PresentationFramework
$msgBody = "Install completed. Create a desktop shortcut for Aki.Launcher.exe, this is how you will join the server. UncleMommy is a bitch."
[System.Windows.MessageBox]::Show($msgBody)
            
            Return "Runs Code"
          }
          'No' 
          {
            Return "Runs Nothing"
          }
      }


          }
          'No' 
          {
			  exit
            Return "Runs Nothing"
          }
      }
        






 
