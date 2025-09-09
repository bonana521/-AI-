@echo off
echo 正在拉取GitHub仓库文件...
echo.

:: 创建仓库目录
if not exist "-AI-" (
    mkdir "-AI-"
    echo 创建 -AI- 目录
)

cd "-AI-"

:: 尝试直接克隆
echo 尝试直接克隆仓库...
git clone https://github.com/bonana521/-AI-.git .
if %ERRORLEVEL% EQU 0 (
    echo 克隆成功！
    goto:check_files
)

:: 尝试代理克隆
echo.
echo 直接克隆失败，尝试使用代理...
git clone https://ghproxy.com/https://github.com/bonana521/-AI-.git .
if %ERRORLEVEL% EQU 0 (
    echo 克隆成功！
    goto:check_files
)

:: 如果都失败，手动下载主要文件
echo.
echo Git克隆失败，尝试手动下载文件...
echo.

:: 下载字体文件
echo 下载77体.ttf...
curl -L "https://raw.githubusercontent.com/bonana521/-AI-/main/77体.ttf" -o "77体.ttf"
if %ERRORLEVEL% EQU 0 (
    echo 字体文件下载成功！
) else (
    echo 字体文件下载失败，请手动下载
)

:: 下载其他可能存在的文件
echo.
echo 检查README文件...
curl -L "https://raw.githubusercontent.com/bonana521/-AI-/main/README.md" -o "README.md"
if %ERRORLEVEL% EQU 0 (
    echo README文件下载成功！
)

echo.
echo 完成！请检查 -AI- 目录中的文件。

:check_files
echo.
echo 下载的文件列表：
dir /b
echo.

pause