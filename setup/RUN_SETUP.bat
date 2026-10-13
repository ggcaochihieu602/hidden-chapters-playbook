@echo off
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0setup.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install_tools.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0set_api_keys.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0verify.ps1"
pause
