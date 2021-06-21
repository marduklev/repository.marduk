@echo off
setlocal
title - create ods file with filelisting\^in %~dp0
color b

del /s /q %~dp0xml_folderfiles.ods

for /r %%a in ("xml\*.xml") do echo %%~nxa
for /r %%a in ("xml\*.xml") do echo %%~na >> xml_folderfiles.ods

echo.
echo creating is done, hit key to close
pause > nul
