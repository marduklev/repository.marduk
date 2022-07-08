@echo off
setlocal
title %~dp0
color b
echo -------------------------------------------------------------------------
echo  create nfo for musicvideos if missing
echo  BETTER DO A SCRAPE AND EXPORT NFO BEFORE AFTER RUN THIS SCRIPT
echo  be sure you dont use any special characters like ^& in filename and foldername
echo  push key to start
echo -------------------------------------------------------------------------
echo.
pause > nul


for /r %%a in (*.avi *.mp4) do call :subroutine_check "%%~na"
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
REM set "artist=%unescapedartist: - =" & set "unescapedtitle=%"
REM set "artist="%unescapedartist:&=^&%"
REM set "title="%unescapedtitle:&=^&%"
echo.
rem goto :debug

if exist "%filepath%.nfo" echo %~1.nfo   already exist - check next
if exist "%filepath%.nfo" goto :eof
if not exist "%filepath%.nfo" echo %~1.nfo   is created now
if not exist "%filepath%.nfo" goto :createnfo

:createnfo
type nul >"%filepath%.nfo"
rem echo. >"%filepath%.nfo"
echo ^<?xml version="1.0" encoding="UTF-8" standalone="yes"?^> > "%filepath%.nfo"
rem echo ^<^!-- https://kodi.wiki/view/NFO_files/Music_videos --^>>> "%filepath%.nfo"
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
rem if exist "%filepath%-*.jpg" echo    ^<^!-- maybe useles as follwowing tags supposed for online lookup not needed seems not needed when local artwork is used --^>>> "%filepath%.nfo"
rem if exist "%filepath%-*.png" echo    ^<^!-- maybe useles as follwowing tags supposed for online lookup not needed seems not needed when local artwork is used --^>>> "%filepath%.nfo"
if exist "%filepath%-artistthumb.jpg" echo    ^<thumb aspect^="thumb" preview^="%filepath%-artistthumb.jpg"^>%filepath%-artistthumb.jpg^</thumb^>>> "%filepath%.nfo"
if exist "%filepath%-thumb.jpg" echo    ^<thumb aspect^="thumb" preview^="%filepath%-thumb.jpg"^>%filepath%-thumb.jpg^</thumb^>>> "%filepath%.nfo"
if exist "%filepath%-landscape.jpg" echo    ^<thumb aspect^="landscape" preview^="%filepath%-landscape.jpg"^>%filepath%-landscape.jpg^</thumb^>>> "%filepath%.nfo"
if exist "%filepath%-fanart.jpg" echo    ^<thumb aspect^="fanart" preview^="%filepath%-fanart.jpg"^>%filepath%-fanart.jpg^</thumb^>>> "%filepath%.nfo"
if exist "%filepath%-poster.jpg" echo    ^<thumb aspect^="poster" preview^="%filepath%-poster.jpg"^>%filepath%-poster.jpg^</thumb^>>> "%filepath%.nfo"
if exist "%filepath%-banner.jpg" echo    ^<thumb aspect^="banner" preview^="%filepath%-banner.jpg"^>%filepath%-banner.jpg^</thumb^>>> "%filepath%.nfo"
if exist "%filepath%-clearlogo.png" echo    ^<thumb aspect^="clearlogo" preview^="%filepath%-clearlogo.jpg"^>%filepath%-clearlogo.jpg^</thumb^>>> "%filepath%.nfo"
if exist "%filepath%-discart.png" echo    ^<thumb aspect^="discart" preview^="%filepath%-discart.png"^>%filepath%discart.png^</thumb^>>> "%filepath%.nfo"
if exist "%filepath%-discart.jpg" echo    ^<thumb aspect^="discart" preview^="%filepath%-discart.jpg"^>%filepath%-discart.jpg^</thumb^>>> "%filepath%.nfo"
echo ^</musicvideo^>>> "%filepath%.nfo"
goto :eof

:debug
echo errorlevel %errorlevel%
echo root %~dp0
echo filenamenoextension %filenamenoextension%
echo artist %artist%
echo title %title%
echo filepath %filepath%
echo.