# The Boys Fika Co-Op Server - Client Install Script
# Author: Codsworth
# Last Updated: 05-14-2024
# Version 0.1


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
            # your code here#Extract modpack + config files for server, overwrite existing
Expand-Archive -Path NewInstall.zip -DestinationPath $PSScriptRoot -Force

Start-Sleep -Seconds 2

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

Add-Type -AssemblyName PresentationCore,PresentationFramework
$msgBody = "Install completed. Don't forgot to create a desktop shortcut for Aki.Launcher.exe, this is how you will join the server. UncleMommy is a bitch."
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
        






 
