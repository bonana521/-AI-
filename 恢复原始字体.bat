@echo off
chcp 65001 >nul
echo ========================================
echo       恢复原始字体工具
echo ========================================
echo.

echo 正在恢复原始CSS文件...

if exist "qiqi_pixel_backup_original.css" (
    copy "qiqi_pixel_backup_original.css" "qiqi_pixel.css"
    echo ✅ 原始CSS文件已恢复！
    echo.
    echo 已恢复为 Press Start 2P 字体
    echo 请刷新浏览器查看效果
) else (
    echo ❌ 未找到备份文件
    echo 请手动恢复 qiqi_pixel.css 文件
)

echo.
pause