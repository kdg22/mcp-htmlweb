@echo off
setlocal
cd /d "%~dp0"
if "%~1"=="" (set MSG=mcp-htmlweb docs/server.json update) else (set MSG=%~1)
git status -sb
git add -A
git diff --cached --quiet
if errorlevel 1 (
  git commit -m "%MSG%"
  if errorlevel 1 exit /b 1
) else (
  echo Nothing to commit.
)
git push origin main
if errorlevel 1 exit /b 1
echo OK: pushed to origin/main
endlocal
