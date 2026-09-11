@echo off
setlocal
chcp 65001 >nul
set "PYTHONUTF8=1"
if exist "%~dp0.venv\Scripts\python.exe" (
  "%~dp0.venv\Scripts\python.exe" "%~dp0scripts\structured_data.py" %*
) else (
  python "%~dp0scripts\structured_data.py" %*
)
exit /b %errorlevel%
