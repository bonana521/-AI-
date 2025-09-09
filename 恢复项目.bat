@echo off
echo ===================================
echo 琪琪AI集成项目恢复脚本
echo ===================================
echo.

cd /d "D:\AI 0.1\2048-game-integrated"

echo 1. 检查当前Git状态...
git status
echo.

echo 2. 检查未推送的提交...
git log --oneline origin/main..HEAD
echo.

echo 3. 如果有未推送的提交，按任意键推送...
pause
git push origin main

echo.
echo 4. 验证项目结构...
echo 当前目录内容：
dir /b
echo.

echo 5. 检查琪琪AI链接是否正确...
findstr "琪琪" games_home.html
echo.

echo ===================================
echo 恢复完成！
echo ===================================
pause