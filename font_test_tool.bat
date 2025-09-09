@echo off
chcp 65001 >nul
echo ========================================
echo    77体字体替换测试工具
echo ========================================
echo.

:: 检查字体文件是否存在
if not exist "77体.ttf" (
    echo 错误：未找到77体.ttf文件
    echo 请确保字体文件在当前目录中
    pause
    exit /b
)

echo 检测到77体.ttf文件
echo 文件大小：%~z1 字节
echo.

:: 创建备份目录
if not exist "font_backup" mkdir font_backup
echo 已创建字体备份目录：font_backup
echo.

:: 显示替换选项
echo 请选择替换方式：
echo 1. 安装字体到系统（推荐）
echo 2. 复制字体到字体目录
echo 3. 创建字体测试文件
echo 4. 查看当前字体信息
echo.
set /p choice=请输入选择 (1-4): 

if "%choice%"=="1" goto install_font
if "%choice%"=="2" goto copy_font
if "%choice%"=="3" goto test_font
if "%choice%"=="4" goto show_info
echo 无效选择
goto end

:install_font
echo.
echo 正在安装字体到系统...
copy "77体.ttf" "%windir%\Fonts\"
if %ERRORLEVEL% EQU 0 (
    echo 字体安装成功！
    echo 正在注册字体...
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "77体" /t REG_SZ /d "77体.ttf" /f
    echo 字体注册完成！
) else (
    echo 安装失败，请以管理员身份运行
)
goto end

:copy_font
echo.
echo 正在复制字体到用户字体目录...
mkdir "%APPDATA%\Microsoft\Windows\Fonts" 2>nul
copy "77体.ttf" "%APPDATA%\Microsoft\Windows\Fonts\"
if %ERRORLEVEL% EQU 0 (
    echo 字体复制成功！
    echo 请重启应用程序以使用新字体
) else (
    echo 复制失败
)
goto end

:test_font
echo.
echo 创建字体测试文件...
echo @echo off > test_font.bat
echo chcp 65001 ^>nul >> test_font.bat
echo echo 测试77体字体效果 >> test_font.bat
echo echo. >> test_font.bat
echo echo 使用77体显示文本： >> test_font.bat
echo echo 如果您看到的是方块，说明字体未正确安装 >> test_font.bat
echo pause >> test_font.bat
echo 测试文件已创建：test_font.bat
goto end

:show_info
echo.
echo 字体文件信息：
echo 文件名：77体.ttf
echo 文件大小：%~z1 字节
echo 创建时间：%~t1
echo.
echo 文件路径：%~f1
goto end

:end
echo.
echo 操作完成！
pause