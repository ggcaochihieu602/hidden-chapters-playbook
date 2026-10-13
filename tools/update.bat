@echo off
cd /d "%~dp0.."
git pull
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install_skill.ps1"
echo.
pause
