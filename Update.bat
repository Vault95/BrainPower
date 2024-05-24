:: The Boys Fika Co-Op Server Pack - Client Update Batch Script
:: Author: Codsworth
:: Last Updated: 05-17-2024
:: Version 1.0 - FINAL
::set variables
echo Checking for updates to installer...
::Create temp folder
mkdir %~dp0temp
::Download live version.txt file from DropBox to temp folder
powershell -Command "Invoke-WebRequest 'https://www.dropbox.com/scl/fi/spl8kfpgvvuuvq1qhjl2z/version.txt?rlkey=lzzfb3cf67zqatzn5978gxpfy&st=e4g5vih4&dl=1' -OutFile %~dp0temp\version.txt"
timeout 2
::change directory to temp folder
cd %~dp0temp
::read live version number from text file
@echo off
set cloudfile=version.txt
echo Reading contents of %cloudfile%:
echo Cloud:
type %cloudfile%
::store live version.txt contents into variable - - MAY NOT BE NEEDED NOW
for /f "delims=" %%i in ('type %cloudfile%') do set "publicversion=%%i"
timeout 1
::Change directory back to where we started
cd ..
::read local version number from text file
@echo off
set localfile=version.txt
echo Reading contents of %localfile%:
echo Local:
type %localfile%
::store local version.txt contents into variable - MAY NOT BE NEEDED NOW
for /f "delims=" %%h in ('type %localfile%') do set "localversion=%%h"
echo.
:: If version matches, proceed with setup script
if "%localversion%"=="%publicversion%" echo Installer up to date... proceeding with Server Pack update
if "%localversion%"=="%publicversion%" powershell -ExecutionPolicy Bypass -File Update.ps1
:: If version does NOT match, download new install script files from github
if NOT "%localversion%"=="%publicversion%" echo Installer is not up to date, updating now...
:: Get current version file, setup & update scripts from cloud
if NOT "%localversion%"=="%publicversion%" powershell -Command "Invoke-WebRequest 'https://www.dropbox.com/scl/fi/3w7l7kgrkbwv7muj1jdsq/Setup.ps1?rlkey=pxhb32hnrba94t5fnnqvtbkd6&st=2nvqo2a8&dl=1' -OutFile %~dp0Setup.ps1"
if NOT "%localversion%"=="%publicversion%" powershell -Command "Invoke-WebRequest 'https://www.dropbox.com/scl/fi/ennk9wdqh8yk0vathqngg/Update.ps1?rlkey=g9e6xzhauqvhjsk64e49rc5ef&st=ui6vkiyo&dl=1' -OutFile %~dp0Update.ps1"
if NOT "%localversion%"=="%publicversion%" powershell -Command "Invoke-WebRequest 'https://www.dropbox.com/scl/fi/spl8kfpgvvuuvq1qhjl2z/version.txt?rlkey=lzzfb3cf67zqatzn5978gxpfy&st=e4g5vih4&dl=1' -OutFile %~dp0version.txt"
if NOT "%localversion%"=="%publicversion%" powershell -Command "[reflection.assembly]::LoadWithPartialName('System.Windows.Forms')|out-null;[windows.forms.messagebox]::Show('Installer has performed a required update. Please run Update.bat file again to proceed.')"
rd /s /q %~dp0temp