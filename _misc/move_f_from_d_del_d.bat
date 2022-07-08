@echo off
TITLE "%~dp0"
COLOR B
ECHO -------------------------------------------------------------------------
ECHO  Move files from folders to base dir
ECHO  Push key to Start
ECHO -------------------------------------------------------------------------
ECHO.
PAUSE > NUL

REM move all files from folders to root = dp0
for /r %%a in (*.*) do (
echo "%%a"
move "%%a" ""
)
REM delete all folders starting from root = dp0
for /d /r %%b in (*) do (
echo "%%~b"
rd /s /q "%%b"
)

ECHO.
ECHO Push key to exit
ECHO.
PAUSE > NUL