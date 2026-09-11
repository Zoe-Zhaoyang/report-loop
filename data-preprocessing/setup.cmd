@echo off
setlocal
chcp 65001 >nul
set "PYTHONUTF8=1"
python -c "import sys; assert sys.version_info >= (3,10), 'Python 3.10+ required'"
if errorlevel 1 exit /b 1
if not exist "%~dp0.venv\Scripts\python.exe" python -m venv "%~dp0.venv"
if errorlevel 1 exit /b 1
"%~dp0.venv\Scripts\python.exe" -m pip install -r "%~dp0requirements.txt"
if errorlevel 1 exit /b 1
"%~dp0.venv\Scripts\python.exe" "%~dp0scripts\structured_data.py" doctor
exit /b %errorlevel%
