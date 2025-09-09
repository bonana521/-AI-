@echo off
echo 正在配置hosts文件绕过DNS解析...
echo.

:: 获取管理员权限
echo 请求管理员权限...
net session >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo 正在请求管理员权限...
    powershell -Command "Start-Process -FilePath '%0' -Verb RunAs"
    exit /b
)

:: 备份原始hosts文件
echo 备份原始hosts文件...
copy "C:\Windows\System32\drivers\etc\hosts" "C:\Windows\System32\drivers\etc\hosts.backup"
echo 备份完成！

:: 添加GitHub IP配置
echo.
echo 添加GitHub IP配置到hosts文件...
(
    echo.
    echo # GitHub IP Configuration - Added on %date%
    echo 20.205.243.166 github.com
    echo 20.205.243.166 www.github.com
    echo 140.82.113.3 api.github.com
    echo 185.199.108.133 raw.githubusercontent.com
    echo 185.199.109.133 raw.githubusercontent.com
    echo 185.199.110.133 raw.githubusercontent.com
    echo 185.199.111.133 raw.githubusercontent.com
    echo 140.82.113.9 gist.github.com
    echo 140.82.114.10 codeload.github.com
) >> "C:\Windows\System32\drivers\etc\hosts"

echo hosts文件配置完成！

:: 刷新DNS缓存
echo.
echo 刷新DNS缓存...
ipconfig /flushdns

echo.
echo 配置完成！现在尝试访问GitHub...
echo.

:: 测试连接
echo 测试GitHub连接...
ping github.com -n 2

echo.
echo 如果仍然无法访问，请尝试：
echo 1. 重启浏览器
echo 2. 清除浏览器缓存
echo 3. 重启网络连接

pause