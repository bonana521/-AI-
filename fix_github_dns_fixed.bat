@echo off
chcp 65001 >nul
echo Configuring hosts file to bypass DNS...
echo.

:: Request administrator privileges
echo Requesting administrator privileges...
net session >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process -FilePath '%0' -Verb RunAs"
    exit /b
)

:: Backup original hosts file
echo Backing up original hosts file...
copy "C:\Windows\System32\drivers\etc\hosts" "C:\Windows\System32\drivers\etc\hosts.backup"
echo Backup completed!

:: Add GitHub IP configuration
echo.
echo Adding GitHub IP configuration to hosts file...
echo # GitHub IP Configuration - Added on %date% >> "C:\Windows\System32\drivers\etc\hosts"
echo 20.205.243.166 github.com >> "C:\Windows\System32\drivers\etc\hosts"
echo 20.205.243.166 www.github.com >> "C:\Windows\System32\drivers\etc\hosts"
echo 140.82.113.3 api.github.com >> "C:\Windows\System32\drivers\etc\hosts"
echo 185.199.108.133 raw.githubusercontent.com >> "C:\Windows\System32\drivers\etc\hosts"
echo 185.199.109.133 raw.githubusercontent.com >> "C:\Windows\System32\drivers\etc\hosts"
echo 185.199.110.133 raw.githubusercontent.com >> "C:\Windows\System32\drivers\etc\hosts"
echo 185.199.111.133 raw.githubusercontent.com >> "C:\Windows\System32\drivers\etc\hosts"
echo 140.82.113.9 gist.github.com >> "C:\Windows\System32\drivers\etc\hosts"
echo 140.82.114.10 codeload.github.com >> "C:\Windows\System32\drivers\etc\hosts"

echo Hosts file configuration completed!

:: Flush DNS cache
echo.
echo Flushing DNS cache...
ipconfig /flushdns

echo.
echo Configuration completed! Now testing GitHub connection...
echo.

:: Test connection
echo Testing GitHub connection...
ping github.com -n 2

echo.
echo If still unable to access, please try:
echo 1. Restart browser
echo 2. Clear browser cache
echo 3. Restart network connection

pause