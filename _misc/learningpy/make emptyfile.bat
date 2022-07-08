@echo off
TITLE %~dp0
COLOR B

rem cd %~dp0
type nul > new_template.py
ECHO # -*- coding: utf-8 -*->> "new_template.py"
ECHO # import 'module_name'>> "new_template.py"
ECHO. >> "new_template.py"
ECHO main():>> "new_template.py"
ECHO.>> "new_template.py"
ECHO.>> "new_template.py"
ECHO if __name__ == '__main__':>> "new_template.py"
ECHO    main()>> "new_template.py"

