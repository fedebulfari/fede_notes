@echo off
setlocal enableextensions disabledelayedexpansion
rem Semantic vault search via the local Miyo CLI; prints Miyo's JSON to stdout.
if "%~1"=="" (
  echo Usage: miyo-search.cmd "query" 1>&2
  exit /b 1
)
set "MIYO=%LOCALAPPDATA%\Miyo\bin\miyo\miyo.exe"
if not exist "%MIYO%" (
  set "MIYO="
  where miyo >nul 2>&1 && set "MIYO=miyo"
)
if not defined MIYO (
  echo Miyo CLI not found. The Miyo desktop app is not installed - tell the user to install Miyo, then retry. Do not retry in a loop. 1>&2
  exit /b 3
)
rem Default closed: only the explicit Unrestricted value may omit Miyo's exact
rem pre-retrieval folder boundary.
rem https://github.com/Brevilabs/obsidian-copilot-private/issues/121
if /I "%COPILOT_MIYO_SEARCH_SCOPE%"=="unrestricted" (
  "%MIYO%" search %* -n 10 --json
  if errorlevel 1 exit /b 1
  exit /b 0
)
if not "%COPILOT_MIYO_SEARCH_SCOPE%"=="" if /I not "%COPILOT_MIYO_SEARCH_SCOPE%"=="current" (
  echo Miyo search received an invalid Search scope. Do not retry or run an unrestricted search. 1>&2
  exit /b 4
)
if not defined COPILOT_MIYO_SEARCH_FOLDER (
  echo Miyo search could not enforce Current vault scope because the active vault identity is missing. Do not retry or run an unrestricted search. 1>&2
  exit /b 4
)
rem Copilot quotes the ticked folders, which go before the vault because a Miyo that
rem searches one folder keeps only the last --folder. The agent's words follow --, so
rem they stay query text and cannot add a --folder. A ticked folder this Miyo lacks
rem fails the whole search, so a failure retries with the vault alone.
rem https://github.com/logancyang/obsidian-copilot/issues/3508
"%MIYO%" search -n 10 %COPILOT_MIYO_SEARCH_EXTRA_FOLDER_ARGS% --folder "%COPILOT_MIYO_SEARCH_FOLDER%" --json -- %*
if not errorlevel 1 exit /b 0
if not defined COPILOT_MIYO_SEARCH_EXTRA_FOLDER_ARGS (
  echo Miyo search could not enforce Current vault scope. Update Miyo, open it, and retry. Do not run an unrestricted search. 1>&2
  exit /b 1
)
"%MIYO%" search -n 10 --folder "%COPILOT_MIYO_SEARCH_FOLDER%" --json -- %*
if errorlevel 1 (
  echo Miyo search could not enforce Current vault scope. Update Miyo, open it, and retry. Do not run an unrestricted search. 1>&2
  exit /b 1
)
echo Miyo search skipped the extra Miyo folders ticked in Copilot settings and searched only the active vault. 1>&2
exit /b 0
