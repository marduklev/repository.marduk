@echo off
setlocal
title %~dp0
color b
echo -------------------------------------------------------------------------
echo  create nfo for musicvideos if missing
echo  BETTER DO A SCRAPE AND EXPORT NFO BEFORE RUN THIS SCRIPT
echo  be sure you dont use any special characters like ^& in filename and foldername
echo  push key to start
echo -------------------------------------------------------------------------
echo.
pause > nul


for /r %%a in (*.mkv *.avi *.mp4) do call :subroutine_check "%%~na"
echo.
echo 	creatin is done
echo 	scroll up to chcek for errors.   push key to exit
echo 	push key to exit
echo.
pause > nul
goto :eof

:subroutine_check
set "filenamenoextension=%~1"
set "filepath=%~dp0%filenamenoextension%\%filenamenoextension%"
set "artist=%filenamenoextension: - =" & set "title=%"
echo.

if exist "%filepath%.nfo" echo %~1.nfo   already exist - check next
if exist "%filepath%.nfo" goto :eof
if not exist "%filepath%.nfo" echo %~1.nfo   is created now
if not exist "%filepath%.nfo" goto :createnfo

:createnfo
type nul >"%filepath%.nfo"
echo ^<?xml version="1.0" encoding="UTF-8" standalone="yes"?^> > "%filepath%.nfo"
echo ^<musicvideo^>>> "%filepath%.nfo"
echo    ^<title^>%title%^</title^>>> "%filepath%.nfo"
echo    ^<rating^>^8.000000^</rating^>>> "%filepath%.nfo"
echo    ^<userrating^>^8^</userrating^>>> "%filepath%.nfo"
echo    ^<year^>^</year^>>> "%filepath%.nfo"
echo    ^<track^>^-1^</track^>>> "%filepath%.nfo"
echo    ^<album^>^</album^>>> "%filepath%.nfo"
echo    ^<plot^>^</plot^>>> "%filepath%.nfo"
echo    ^<genre^>^</genre^>>> "%filepath%.nfo"
echo    ^<director^>^</director^>>> "%filepath%.nfo"
echo    ^<premiered^>^</premiered^>>> "%filepath%.nfo"
echo    ^<year^>^</year^>>> "%filepath%.nfo"
echo    ^<studio^>^</studio^>>> "%filepath%.nfo"
echo    ^<artist^>%artist%^</artist^>>> "%filepath%.nfo"
echo ^</musicvideo^>>> "%filepath%.nfo"
goto :eof