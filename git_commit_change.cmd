@echo off
setlocal

set "BASH_EXE="
if exist "%ProgramFiles%\Git\bin\bash.exe" set "BASH_EXE=%ProgramFiles%\Git\bin\bash.exe"
if not defined BASH_EXE if exist "%ProgramFiles(x86)%\Git\bin\bash.exe" set "BASH_EXE=%ProgramFiles(x86)%\Git\bin\bash.exe"
if not defined BASH_EXE (
  echo Git Bash was not found. Install Git for Windows or run: bash git_commit_change.sh
  exit /b 1
)

"%BASH_EXE%" "%~dp0git_commit_change.sh" %*
exit /b %ERRORLEVEL%
