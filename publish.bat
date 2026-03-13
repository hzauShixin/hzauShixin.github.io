@echo off
chcp 65001 > nul
echo ========================================
echo   Quarto 网站发布工具
echo ========================================
echo.

:: 设置临时目录到无中文路径，解决编码问题
set TEMP=C:\quarto-tmp
set TMP=C:\quarto-tmp

:: 设置 Quarto 路径
set PATH=%PATH%;D:\Positron\resources\app\quarto\bin

:: 切换到项目目录
cd /d C:\quarto-site\my-website

echo [1/3] 正在渲染网站...
quarto render
if %errorlevel% neq 0 (
    echo.
    echo [错误] 渲染失败，请检查 .qmd 文件内容。
    pause
    exit /b 1
)

echo.
echo [2/3] 正在提交到 Git...
git add .
git commit -m "Update website content"

echo.
echo [3/3] 正在推送到 GitHub...
git pull origin main --rebase
git push origin main
if %errorlevel% neq 0 (
    echo.
    echo [错误] 推送失败，请检查网络或 GitHub 认证。
    pause
    exit /b 1
)

echo.
echo ========================================
echo   发布成功！
echo   网站地址：https://hzauShixin.github.io/
echo   等待约 1-2 分钟后刷新即可看到更新。
echo ========================================
echo.
pause
