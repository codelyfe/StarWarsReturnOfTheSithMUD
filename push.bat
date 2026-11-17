@echo off
setlocal
cd /d "%~dp0"
git add -A
git diff --cached --quiet
if errorlevel 1 (
  if "%~1"=="" (
    git commit -m "Update"
  ) else (
    git commit -m "%~1"
  )
)
git push
endlocal
