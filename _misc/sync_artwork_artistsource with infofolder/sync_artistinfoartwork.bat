@ECHO off
setlocal
COLOR C
ECHO -------------------------------------------------------------------------
ECHO                   ** sync artistinfoartwork **
ECHO -------------------------------------------------------------------------

for /d %%t in (*) do (
	ECHO.
	ECHO source: %~dp0%%~t\
	ECHO target: **TARGET**\%%~t\
	ECHO.
	xcopy "%~dp0%%~t\" "**TARGET**\%%~t\" /k /exclude:exclude_default.txt
)

ECHO.
ECHO done
PAUSE > NUL
