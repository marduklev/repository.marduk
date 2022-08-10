@ECHO off
setlocal
COLOR C

ECHO.
ECHO.
FOR /r %%a in (*trailer.*) do call :check "%%~a"  "%%~dpa"
ECHO.
ECHO.
FOR /r %%c in ("*old_tag.nfo") DO (
	del "%%c"
)
PAUSE > nul
goto :end

:check
ECHO.
SET "nfo=%~2\tvshow.nfo"
SET "tvshow_dir=%~2"
SET "new_url=%~1"
SET "old_tag=empty"
ECHO.

if exist "%~2/tvshow.nfo" (
	
	type "%nfo%" | find "<trailer>" > "%~2\old_tag.nfo"
	for /f "delims=" %%b in ('type "%~2\old_tag.nfo"') do (
		set "old_tag=%%b"
	)
	) else (
	echo no nfo found
)
echo nfo :        "%nfo%"
echo tvshow_dir : "%tvshow_dir%"
echo old_tag :    "%old_tag%"
echo new_tag :    "    <trailer>%new_url%</trailer>"

rem "unknown;string;unicode;bigendianunicode;utf8;utf7;utf32;ascii;default;oem"
powershell -Command "(gc '%nfo%') -replace '%old_tag%', '    <trailer>%~1</trailer>' | Out-File -encoding utf8 '%nfo%'"

goto :eof
