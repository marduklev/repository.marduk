@echo off & setlocal
title %~dp0
color b
echo -------------------------------------------------------------------------
echo  push key to start
echo -------------------------------------------------------------------------
echo.
pause > nul

For /R %%a in (disc.* medium.*) DO IF EXIST "%%a" (
echo %%a
REN "%%a" "discart.*"
)
 
 
For /R %%b in (folder.jpg) DO IF EXIST "%%b" (
echo %%b
REN"%%b" "thumb.jpg"

)
echo.
pause > nul
