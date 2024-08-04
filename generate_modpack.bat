set next_version="0.2.7"
set folder_name="MODPACK"
set folder_config_origin="server_files\BepInEx\config"
set folder_config_destiny="Bepinex\config"
set folder_plugins_origin="server_files\BepInEx\plugins"
set folder_plugins_destiny="Bepinex\plugins"


rd /q /s %folder_name%
md %folder_name%\Bepinex\config
md %folder_name%\Bepinex\config\Almanac
md %folder_name%\Bepinex\plugins

copy "%~dp0modpack_tools\*" "%~dp0%folder_name%"
copy "%~dp0modpack_files\*" "%~dp0%folder_name%\%folder_config_destiny%"

copy "%~dp0%folder_config_origin%\Azumatt.AzuAutoStore.cfg" "%~dp0%folder_name%\%folder_config_destiny%"
copy "%~dp0%folder_config_origin%\Azumatt.AzuCraftyBoxes.cfg" "%~dp0%folder_name%\%folder_config_destiny%"
copy "%~dp0%folder_config_origin%\Azumatt.AzuExtendedPlayerInventory.cfg" "%~dp0%folder_name%\%folder_config_destiny%"
copy "%~dp0%folder_config_origin%\Azumatt.FastLink.cfg" "%~dp0%folder_name%\%folder_config_destiny%"
copy "%~dp0%folder_config_origin%\Azumatt.XRayVision.cfg" "%~dp0%folder_name%\%folder_config_destiny%"
copy "%~dp0BepInEx\plugins\Smoothbrain-Backpacks\Backpacks.Spanish.yml" "%~dp0%folder_name%\%folder_config_destiny%"
copy "%~dp0%folder_config_origin%\org.bepinex.plugins.groups.cfg" "%~dp0%folder_name%\%folder_config_destiny%"
copy "%~dp0%folder_config_origin%\randyknapp.mods.epicloot.cfg" "%~dp0%folder_name%\%folder_config_destiny%"

xcopy /S "%~dp0%folder_config_origin%\Almanac" "%~dp0%folder_name%\%folder_config_destiny%\Almanac"

xcopy /S "%~dp0%folder_plugins_origin%" "%~dp0%folder_name%\%folder_plugins_destiny%"

set FILETOZIP="%~dp0%folder_name%"

set TEMPDIR="%~dp0temp"
rd /q /s %TEMPDIR%
mkdir %TEMPDIR%
xcopy /s %FILETOZIP% %TEMPDIR%

echo Set objArgs = WScript.Arguments > _zipIt.vbs
echo InputFolder = objArgs(0) >> _zipIt.vbs
echo ZipFile = objArgs(1) >> _zipIt.vbs
echo CreateObject("Scripting.FileSystemObject").CreateTextFile(ZipFile, True).Write "PK" ^& Chr(5) ^& Chr(6) ^& String(18, vbNullChar) >> _zipIt.vbs
echo Set objShell = CreateObject("Shell.Application") >> _zipIt.vbs
echo Set source = objShell.NameSpace(InputFolder).Items >> _zipIt.vbs
echo objShell.NameSpace(ZipFile).CopyHere(source) >> _zipIt.vbs
echo wScript.Sleep 2000 >> _zipIt.vbs

CScript  _zipIt.vbs  %TEMPDIR%  "%~dp0%folder_name%\TURBEHEIM-TURBEHEIM-%next_version%.zip"

rd /q /s %TEMPDIR%
del _zipIt.vbs