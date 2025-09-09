@echo off
chcp 65001 >nul
title 琪琪AI集成项目恢复脚本

echo ╔══════════════════════════════════════════════════════════════╗
echo ║               琪琪AI集成项目恢复脚本 v1.0                    ║
echo ║                  保存时间: 2025-09-07 23:50                 ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

cd /d "D:\AI 0.1\2048-game-integrated" 2>nul
if errorlevel 1 (
    echo ❌ 错误: 找不到项目目录 D:\AI 0.1\2048-game-integrated\
    echo.
    echo 请确保项目目录存在！
    pause
    exit /b 1
)

echo 📍 当前目录: %CD%
echo.

echo 🔍 检查当前Git状态...
echo ──────────────────────────────────────────────────────────────
git status
echo.

echo 📜 检查未推送的提交...
echo ──────────────────────────────────────────────────────────────
git log --oneline origin/main..HEAD 2>nul
if errorlevel 1 (
    echo ✅ 没有未推送的提交
) else (
    echo ⚠️  发现未推送的提交
)
echo.

echo 📁 检查项目结构...
echo ──────────────────────────────────────────────────────────────
echo 当前目录内容:
dir /b *.html *.md README* 2>nul
echo.

echo 🔍 检查琪琪AI配置...
echo ──────────────────────────────────────────────────────────────
if exist "games_home.html" (
    echo ✅ games_home.html 存在
    findstr /C:"bonana521.github.io" games_home.html >nul
    if errorlevel 1 (
        echo ❌ 琪琪AI链接配置可能有问题
    ) else (
        echo ✅ 琪琪AI外部链接配置正确
    )
) else (
    echo ❌ games_home.html 不存在
)
echo.

echo 🌐 测试网络连接...
echo ──────────────────────────────────────────────────────────────
ping -n 1 github.com >nul 2>&1
if errorlevel 1 (
    echo ❌ 无法连接到GitHub (网络问题)
    echo.
    echo 💡 建议:
    echo    1. 检查网络连接
    echo    2. 尝试切换VPN或代理
    echo    3. 稍后重试
) else (
    echo ✅ 网络连接正常
)
echo.

echo 📋 推荐操作:
echo ──────────────────────────────────────────────────────────────
git log --oneline origin/main..HEAD 2>nul
if errorlevel 1 (
    echo ✅ 所有提交已推送，无需操作
) else (
    echo ⚠️  发现未推送提交，建议:
    echo    1. 推送提交: git push origin main
    echo    2. 验证网站: https://bonana521.github.io/2048-game/games_home.html
)
echo.

echo 🎯 验证网站状态:
echo    游戏主页: https://bonana521.github.io/2048-game/games_home.html
echo    琪琪AI: https://bonana521.github.io/-AI-/
echo.

set /p choice="是否要推送未完成的提交? (y/n): "
if /i "%choice%"=="y" (
    echo.
    echo 🚀 正在推送提交...
    git push origin main
    if errorlevel 1 (
        echo ❌ 推送失败，请检查网络连接
    ) else (
        echo ✅ 推送成功！
    )
)

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                        恢复完成                            ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

pause