@echo off
TITLE %~dp0
COLOR C

rem C:\Users\mardu\AppData\Local\Programs\Python\Python310\python.exe -m pip install --upgrade pip
rem https://stackoverflow.com/questions/67442661/warning-ignoring-invalid-distribution-ip-c-python39-lib-site-packages-how-d
rem python -m pip install clipboard
REM pip install clipboard


echo result start
echo _____________
py %~dp0build_xsp_paths_urlencode_decode_kodi.py

rem py %~dp0tkinter_test.py
echo _____________
echo result end
echo.

PAUSE > NUL