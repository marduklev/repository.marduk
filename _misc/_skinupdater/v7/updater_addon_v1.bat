@ECHO off
setlocal
COLOR C
ECHO -------------------------------------------------------------------------
ECHO                   ** Update addon **
ECHO -------------------------------------------------------------------------


:startup
set "addon_tempforzip_dir=%~dp0_package"
set "run_all=false"

rem create exclude files for bat op
IF NOT EXIST "exclude_default.txt" (
(
	echo .gitattributes
	echo .gitignore
	echo changelog.txt
	echo LICENSE.txt
	echo README.md
)>"exclude_default.txt"
)

rem check for setting .ini
IF EXIST "addonupdater.ini" (
	goto :get_config
	) ELSE (
	goto :user_setconfig
)

rem set var strings to ini used as settings
:user_setconfig
rem dialog command syntax
SET powershell_choose_folder=powershell -noprofile -command "&{[System.Reflection.Assembly]::LoadWithPartialName('System.windows.forms') | Out-Null;$FolderBrowserDialog = New-Object System.Windows.Forms.FolderBrowserDialog; $FolderBrowserDialog.RootFolder = 'MyComputer'; $FolderBrowserDialog.ShowDialog()|out-null; $FolderBrowserDialog.SelectedPath}"
SET powershell_choose_file=powershell -noprofile -command "&{[System.Reflection.Assembly]::LoadWithPartialName('System.windows.forms') | Out-Null;$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog; $OpenFileDialog.ShowDialog()|out-null; $OpenFileDialog.FileName}"

ECHO.
ECHO Welcome, first set up required stuff
ECHO.


rem user input
SET /p addon_name=type the textlabel of addon name [eg script.swan.helper] ! :
ECHO addon_name=%addon_name%>> "addonupdater.ini"

SET /p addon_currentversionsuffix=type the value of current addon version [eg. 19.1.20] ! :
ECHO addon_currentversionsuffix=%addon_currentversionsuffix%>> "addonupdater.ini"

SET /p addon_versionsuffix=type the value of addon to bump to  [eg. 19.1.21] ! :
ECHO addon_versionsuffix=%addon_versionsuffix%>> "addonupdater.ini"

ECHO Choose the Location of your addon WORKIN DIRECTORY - Hit Enter
pause > nul
for /f "delims=" %%z in ('%powershell_choose_folder%') do set "addon_working_dir=%%z"
ECHO addon_working_dir=%addon_working_dir%>> "addonupdater.ini"

ECHO Choose the Location of GIT HUB BRANCH DIRECTORY - Hit Enter
pause > nul
for /f "delims=" %%z in ('%powershell_choose_folder%') do set "addon_git_dir=%%z"
ECHO addon_git_dir=%addon_git_dir%>> "addonupdater.ini"
rem create or append gitignore


ECHO Choose the Location of KODI REPOSITORY ( the root directory where %addon_name%\ package should be updated ) - Hit Enter
pause > nul
for /f "delims=" %%z in ('%powershell_choose_folder%') do set "addon_kodirepo_dir=%%z"
ECHO addon_kodirepo_dir=%addon_kodirepo_dir%>> "addonupdater.ini"

ECHO.
ECHO Done. For a fresh start delete addonupdater.ini manually
ECHO.



goto :get_config

rem read ini values and set strings
:get_config
for /f "tokens=1,2 delims==" %%a in (addonupdater.ini) do (
	if %%a==addon_name set "addon_name=%%b"
	if %%a==addon_currentversionsuffix set "addon_currentversionsuffix=%%b"
	if %%a==addon_versionsuffix set "addon_versionsuffix=%%b"
	if %%a==texturepacker_executablelocation set "texturepacker_executablelocation=%%b"
	if %%a==addon_working_dir set "addon_working_dir=%%b"
	if %%a==addon_git_dir set "addon_git_dir=%%b"
	if %%a==addon_kodirepo_dir set "addon_kodirepo_dir=%%b"
)


goto :OPTIONS 

:OPTIONS
ECHO.
ECHO  ***    OPTIONS   ***
ECHO.
ECHO    1. RUN ALL AT ONCE ( 2 - 5 )
ECHO.
ECHO    2.       Update git branch
ECHO.
ECHO    3.       Update your Kodi Repo (creates zip packages ,updates *.xml and md5 checksum)
ECHO.
ECHO    4. CLOSE
ECHO.
ECHO    5.       rebuild addon xml
ECHO.

CHOICE /C 12345 /M "Enter your ^choice and hit enter:"

IF ERRORLEVEL 5 GOTO sub_build_addonsxml
IF ERRORLEVEL 4 GOTO END
IF ERRORLEVEL 3 GOTO update_repo
IF ERRORLEVEL 2 GOTO update_git
IF ERRORLEVEL 1 GOTO run_all

:run_all
set "run_all=true"
goto :update_git

:auto_routine
IF "%run_all%" == "true" (
	goto :%nextstep%
		) ELSE (
    ECHO.
	ECHO.
	ECHO ----------------------------------------------------------------------------------------
	ECHO ----------------------------------------------------------------------------------------
	ECHO                ** Finished - scroll up to check for errors. **
	ECHO              ** When done Hit a Key to Going back to to options **
	ECHO ----------------------------------------------------------------------------------------
	ECHO ----------------------------------------------------------------------------------------
	ECHO.
	pause > nul
	goto :OPTIONS
)

REM rem 1 - update git dir ( copy new files from working_dir to git_dir ) 
:update_git
set "nextstep=update_repo"

rem copy new files to git
ECHO.
xcopy "%addon_working_dir%" "%addon_git_dir%" /d /k /y /v /s /exclude:exclude_default.txt

rem conditional del img files from working dir after copy/backup
ECHO.

if "%run_all%" == "false" goto :options
if "%run_all%" == "true" goto :update_repo
	)	else	(
	goto :auto_routine
)

REM rem 3
:update_repo
set "nextstep=sub_build_addonsxml"

rem copy files to addon_tempforzip_dir
xcopy "%addon_working_dir%" "%addon_tempforzip_dir%\%addon_name%\" /k /y /v /s /exclude:exclude_default.txt

rem bump version value in addon.xml - last on to do in genrell - better solution needed may use find, replace <file.ext, or
ECHO.
powershell -Command "(gc '%addon_tempforzip_dir%\%addon_name%\addon.xml') -replace '%addon_currentversionsuffix%', '%addon_versionsuffix%' | Out-File -encoding default '%addon_tempforzip_dir%\%addon_name%\addon.xml'"

rem create zip + md5 in repo_dir
ECHO.
rem zip via tar
cd %addon_tempforzip_dir%\
tar -a -cf "%addon_kodirepo_dir%\%addon_name%\%addon_name%-%addon_versionsuffix%.zip" "%addon_name%"
cd %~dp0

rem generate md5 for %addon_kodirepo_dir%\%addon_name%\%addon_name%-%addon_versionsuffix%.zip package
certutil -hashfile "%addon_kodirepo_dir%\%addon_name%\%addon_name%-%addon_versionsuffix%.zip" md5 | find /i /v "md5" | find /i /v "certutil" > %addon_kodirepo_dir%\%addon_name%\%addon_name%-%addon_versionsuffix%.zip.md5

rem copy addon xml from temp_dir to repo_dir and generate md5
ECHO.
copy "%addon_tempforzip_dir%\%addon_name%\addon.xml" "%addon_kodirepo_dir%\%addon_name%\"
ECHO.

:sub_build_addonsxml
set "nextstep=END"
rem new rebuild addons.xml
cd %addon_kodirepo_dir%
echo ^<^?xml version^=^"1.0^" encoding^=^"UTF-8^" standalone=^"yes^"^?^>> "addons.xml"
echo     ^<addons^>>> "addons.xml"
FOR /r %%b in ("addon.xml") DO IF EXIST "%%b" (
	type "%%~pbaddon.xml" | find /i /v "UTF-8" >> addons.xml
)
echo     ^</addons^>>> "addons.xml"
certutil -hashfile "addons.xml" md5 | find /i /v "md5" | find /i /v "certutil" > addons.xml.md5
cd %~dp0

goto :auto_routine

xcopy "%addon_git_dir%" "%addon_working_dir%\" /d /k /y /v /s /exclude:exclude_git_t_wd.txt
xcopy "%addon_git_dir%\_xbt" "%addon_working_dir%\media\" /d /k /y /v /s
goto :auto_routine

:END
REM exit

REM todo https://github.com/joshnh/Git-Commands
REM git add --all
REM git commit -m "next commit here" .
REM git push -u origin master
REM git pull