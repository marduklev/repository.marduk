@echo off
setlocal
COLOR C
ECHO -------------------------------------------------------------------------
ECHO                   ** Update Skin **
ECHO -------------------------------------------------------------------------

IF EXIST "skinupdater.ini" (
	goto :read_ini
	) ELSE (
	goto :user_setconfig
)


rem merge  set & write to ini,
:user_setconfig
rem dialog command syntax
SET powershell_choose_file=powershell -noprofile -command "&{[System.Reflection.Assembly]::LoadWithPartialName('System.windows.forms') | Out-Null;$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog; $OpenFileDialog.ShowDialog()|out-null; $OpenFileDialog.FileName}"
SET powershell_choose_folder=powershell -noprofile -command "&{[System.Reflection.Assembly]::LoadWithPartialName('System.windows.forms') | Out-Null;$FolderBrowserDialog = New-Object System.Windows.Forms.FolderBrowserDialog; $FolderBrowserDialog.RootFolder = 'MyComputer'; $FolderBrowserDialog.ShowDialog()|out-null; $FolderBrowserDialog.SelectedPath}"

rem powershell set file
REM just use when not using tar, or prefer using 7zip app
echo Choose ^7zip executable - Hit Enter
pause > nul
for /f "delims=" %%z in ('%powershell_choose_file%') do set "zip_executablelocation=%%z"
	
rem user input
SET /p skin_name=type the textlabel of addon name [eg skin.swan] ! :
SET /p skin_currentversionsuffix=type the vslue of current addon version [eg. 19.1.20] ! :
SET /p skin_versionsuffix=type the value of addon to bump to  [eg. 19.1.21] ! :

rem powershell set folder, when doin this way io need resolve path usage using var strings like: skin_versionlabel , skin_name
echo Choose the Location of Texturepacker executable - Hit Enter
pause > nul
for /f "delims=" %%z in ('%powershell_choose_folder%') do set "texturepacker_executablelocation=%%z"

echo Choose the Location of your skin WORKIN DIRECTORY - Hit Enter
pause > nul
for /f "delims=" %%z in ('%powershell_choose_folder%') do set "skin_working_dir=%%z"

echo Choose the Location of GIT HUB BRANCH DIRECTORY - Hit Enter
pause > nul
for /f "delims=" %%z in ('%powershell_choose_folder%') do set "skin_git_dir=%%z"

echo Choose the Location of KODI REPOSITORY ( the root directory where %skin_name%\ package should be updated ) - Hit Enter
pause > nul
for /f "delims=" %%z in ('%powershell_choose_folder%') do set "skin_kodirepo_dir=%%z"

goto :write_ini

rem goto :write_ini
rem later do write to ini in prev routine
:write_ini
echo zip_executablelocation=%zip_executablelocation%> "skinupdater.ini"

echo skin_name=%skin_name%>> "skinupdater.ini"
echo skin_currentversionsuffix=%skin_currentversionsuffix%>> "skinupdater.ini"
echo skin_versionsuffix=%skin_versionsuffix%>> "skinupdater.ini"

echo texturepacker_executablelocation=%texturepacker_executablelocation%>> "skinupdater.ini"
echo skin_working_dir=%skin_working_dir%>> "skinupdater.ini"
echo skin_git_dir=%skin_git_dir%>> "skinupdater.ini"
echo skin_kodirepo_dir=%skin_kodirepo_dir%>> "skinupdater.ini"

goto :read_ini

rem read ini values and set strings
:read_ini
for /f "tokens=1,2 delims==" %%a in (skinupdater.ini) do (
	if %%a==zip_executablelocation set "zip_executablelocation=%%b"
	if %%a==skin_name set "skin_name=%%b"
	if %%a==skin_currentversionsuffix set "skin_currentversionsuffix=%%b"
	if %%a==skin_versionsuffix set "skin_versionsuffix=%%b"
	if %%a==texturepacker_executablelocation set "texturepacker_executablelocation=%%b"
	if %%a==skin_working_dir set "skin_working_dir=%%b"
	if %%a==skin_git_dir set "skin_git_dir=%%b"
	if %%a==skin_kodirepo_dir set "skin_kodirepo_dir=%%b"
)
rem goto :test 
goto :startup 

:test
rem  the other stuff
echo zip_executablelocation : %zip_executablelocation%

echo skin_name : %skin_name%
echo skin_currentversionsuffix : %skin_currentversionsuffix%
echo skin_versionsuffix : %skin_versionsuffix%
rem no longer needed echo skin_versionlabel : %skin_versionlabel%

echo texturepacker_executablelocation : %texturepacker_executablelocation%
echo skin_working_dir : %skin_working_dir%
echo skin_git_dir : %skin_git_dir%
echo skin_kodirepo_dir : %skin_kodirepo_dir%

goto :startup


:startup
set "skin_tempforzip_dir=%~dp0_package"
set "run_all=false"
set "compile=false"

rem check for new imgs
cd %skin_working_dir%\media\
FOR /r %%a in (*.png *.jpg) DO IF EXIST "%%a" ( 
	set "compile=true"
	echo   	 "%%a"
)
echo.
if "%compile%" == "true" echo      - can be compiled
cd %~dp0

:OPTIONS
ECHO.
ECHO  ***    OPTIONS   ***
ECHO.
ECHO    1. RUN ALL AT ONCE
ECHO.
ECHO    2. update_git
ECHO.
ECHO    3. texture_compile
ECHO.
ECHO    4. update_repo
ECHO.
ECHO    5. CLOSE
ECHO.

CHOICE /C 12345 /M "Enter your ^choice and hit enter:"
IF ERRORLEVEL 5 GOTO END
IF ERRORLEVEL 4 GOTO update_repo
IF ERRORLEVEL 3 GOTO texture_compile
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
set "nextstep=texture_compile"

rem copy new files to git - exclude xbt to git
ECHO.
xcopy "%skin_working_dir%" "%skin_git_dir%" /d /k /y /v /s /exclude:exclude_default.txt

rem conditional del img files from working dir after copy/backup
ECHO.
if "%compile%" == "true" (
	cd %skin_working_dir%\media\
	FOR /d /r %%b in ("*") DO IF EXIST "%%b" ( rd /s /q "%%b")
	FOR /r %%c in (*.png *.jpg) DO IF EXIST "%%c" ( del "%%c")
	cd %~dp0
)

if "%run_all%" == "false" if "%compile%" == "false" goto :options
if "%run_all%" == "true" if "%compile%" == "false" goto :update_repo
	)	else	(
	goto :texture_compile
)

REM rem 2 - compile texture
:texture_compile
set "nextstep=update_repo"

ECHO.
rem compile xbt for zip package
if "%run_all%" == "true" if "%compile%" == "true" (
	if not exist "%skin_tempforzip_dir%\%skin_name%\media\" md "%skin_tempforzip_dir%\%skin_name%\media\"
	set "xbt_dir=%skin_tempforzip_dir%\%skin_name%\media"
)

rem compile new textures to working dir from git to to git _xbt folder
if "%run_all%" == "false" if "%compile%" == "true" (
	rem unresolved issues with spaces in outputdir pathname
		rem set "xbt_dir=%skin_working_dir%\test"set
	set "xbt_dir=%skin_git_dir%\_xbt"
	copy "%xbt_dir%\*.xbt" "%skin_working_dir%\%skin_name%\media\"
)

rem forced fallback via options - compile from git to to git _xbt folder
if "%run_all%" == "false" if "%compile%" == "false" (
	set "xbt_dir=%skin_git_dir%\_xbt"
)

START /B /WAIT %texturepacker_executablelocation% -dupecheck -input %skin_git_dir%\media\ -output "%xbt_dir%\Textures.xbt"
cd %skin_git_dir%\themes\
	for /d %%t in (*) do (
	echo.
	echo Create ^*Theme^*.xbt from %%~t
	echo.
	START /B /WAIT %texturepacker_executablelocation% -dupecheck -input %skin_git_dir%\themes\%%~t\ -output %xbt_dir%\%%~t.xbt
	cd %~dp0
)
goto :auto_routine

REM rem 3
:update_repo
set "nextstep=END"

rem copy files to skin_tempforzip_dir + conditional include or exclude xbt
IF "%compile%" == "true" (
	xcopy "%skin_working_dir%" "%skin_tempforzip_dir%\%skin_name%\" /k /y /v /s /exclude:exclude_default.txt
		) ELSE (
	xcopy "%skin_working_dir%" "%skin_tempforzip_dir%\%skin_name%\" /k /y /v /s /exclude:exclude_default_include_xbt.txt
)
rem bump version value in addon.xml - last on to do in genrell - better solution needed may use find, replace <file.ext, or
echo.
powershell -Command "(gc '%skin_tempforzip_dir%\%skin_name%\addon.xml') -replace '%skin_currentversionsuffix%', '%skin_versionsuffix%' | Out-File -encoding default '%skin_tempforzip_dir%\%skin_name%\addon.xml'"

rem create zip + md5 in repo_dir
echo.
rem do with 7zip 
%zip_executablelocation% a -tzip "%skin_kodirepo_dir%\%skin_name%\%skin_name%-%skin_versionsuffix%.zip" "%skin_tempforzip_dir%\%skin_name%"

rem zip via native compress less good compression
rem powershell -Command "(Compress-Archive -Force -Path %skin_tempforzip_dir%\*%skin_name% -DestinationPath %skin_kodirepo_dir%\%skin_name%\%skin_name%-%skin_versionsuffix%.zip)"

rem zip via tar
REM cd %skin_tempforzip_dir%\
REM tar -a -cf "%skin_kodirepo_dir%\%skin_name%\%skin_name%-%skin_versionsuffix%.zip" "%skin_name%"
REM cd %~dp0

rem generate md5 for %skin_kodirepo_dir%\%skin_name%\%skin_name%-%skin_versionsuffix%.zip package
certutil -hashfile "%skin_kodirepo_dir%\%skin_name%\%skin_name%-%skin_versionsuffix%.zip" md5 | find /i /v "md5" | find /i /v "certutil" > %skin_kodirepo_dir%\%skin_name%\%skin_name%-%skin_versionsuffix%.zip.md5

rem copy addon xml from temp_dir to repo_dir and generate md5
echo.
copy "%skin_tempforzip_dir%\%skin_name%\addon.xml" "%skin_kodirepo_dir%\%skin_name%\"
echo.
powershell -Command "(gc '%skin_kodirepo_dir%\addons.xml') -replace '%skin_currentversionsuffix%', '%skin_versionsuffix%' | Out-File -encoding default '%skin_kodirepo_dir%\addons.xml'"
certutil -hashfile "%skin_kodirepo_dir%\addons.xml" md5 | find /i /v "md5" | find /i /v "certutil" > %skin_kodirepo_dir%\addons.xml.md5
goto :auto_routine

:END
REM exit