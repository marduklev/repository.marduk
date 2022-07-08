@echo off
TITLE %~dp0
COLOR B
ECHO -------------------------------------------------------------------------
ECHO  Put files into folders using Filename
ECHO  Push key to Start
ECHO -------------------------------------------------------------------------
ECHO.
PAUSE > NUL
for %%a in (*.jpg *.png *.mp3) do (
echo %~dp0
echo %%~na

REM md "%%~na" 2>nul
REM move "%%a" "%%~na"
)
ECHO.
ECHO Push key to exit
ECHO.
PAUSE > NUL