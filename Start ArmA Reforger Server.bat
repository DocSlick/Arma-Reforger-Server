@echo off
TITLE ArmA Reforger Server - Status
COLOR 0A
    :: DEFINE the following variables where applicable to your install.
    :: Make sure your ConfigFolder has your account name and not Administrator if you are not using the built-in Windows admin account!
    SET SteamLogin=anonymous
    SET ReforgerBranch=1874900
    SET ReforgerServerPath="C:\Servers\ArmaReforgerServer1"
    SET SteamCMDPath="C:\Servers\SteamCMD"
    SET ProfileFolder="C:\Servers\ArmaReforgerServer1\profile"
    SET ConfigFolder="C:\Servers\ArmaReforgerServer1\profile"
    :: _______________________________________________________________


goto checkServer
pause

:checkServer
tasklist /fi "imagename eq ArmaReforgerServer.exe" 2>NUL | find /i /n "ArmaReforgerServer.exe">NUL
if "%ERRORLEVEL%"=="0" goto loopServer
cls
echo Server is not running, taking care of it..
goto killServer

:loopServer
FOR /L %%s IN (30,-1,0) DO (
    cls
    echo Server is running. Checking again in %%s seconds..
    timeout 1 >nul
)
goto checkServer

:killServer
taskkill /f /im ArmaReforgerServer.exe
goto updateServer

:updateServer
cls
echo Updating ArmA Reforger Server.
timeout 1 >nul
cls
echo Updating ArmA Reforger Server..
timeout 1 >nul
cls
echo Updating ArmA Reforger Server...
cd "%SteamCMDPath%"
steamcmd.exe +force_install_dir %ReforgerServerPath% +login %SteamLogin% +"app_update %ReforgerBranch%" +quit
goto startServer

:startServer
cls
echo ArmA Reforger Server.
timeout 1 >nul
cls
echo ArmA ReforgerA Server..
timeout 1 >nul
cls
echo ArmA Reforger Server...
cd "%ReforgerServerPath%"
start ArmaReforgerServer.exe -profile %ProfileFolder% -config %ConfigFolder%\config.json
goto checkServer