@echo off
echo 正在下载77体.ttf字体文件...
echo.

:: 方法1: 直接下载
echo 尝试直接下载...
curl -L "https://raw.githubusercontent.com/bonana521/-AI-/main/77体.ttf" -o "77体.ttf"
if %ERRORLEVEL% EQU 0 (
    echo 下载成功！
    goto:end
)

:: 方法2: 使用代理
echo.
echo 直接下载失败，尝试使用代理...
curl -L "https://ghproxy.com/https://raw.githubusercontent.com/bonana521/-AI-/main/77体.ttf" -o "77体.ttf"
if %ERRORLEVEL% EQU 0 (
    echo 下载成功！
    goto:end
)

:: 方法3: 使用wget
echo.
echo 代理下载失败，尝试使用wget...
wget "https://raw.githubusercontent.com/bonana521/-AI-/main/77体.ttf" -O "77体.ttf"
if %ERRORLEVEL% EQU 0 (
    echo 下载成功！
    goto:end
)

echo.
echo 所有下载方法都失败了，请检查网络连接或手动下载：
echo https://github.com/bonana521/-AI-/pull/1/files

:end
echo.
pause