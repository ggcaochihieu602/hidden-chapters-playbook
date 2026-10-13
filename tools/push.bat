@echo off
cd /d "%~dp0.."
git add -A
git commit -m "Cap nhat playbook %date% %time%"
git push
echo.
echo Da day ban moi len GitHub.
pause
