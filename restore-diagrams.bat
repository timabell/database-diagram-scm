REM depends on sqlcmd which comes as part of ssms
REM connects to default instance on localhost by default

@echo off
Setlocal EnableDelayedExpansion
Setlocal EnableExtensions

if "!server!"==""   set server=.
if "!database!"=="" set database=ExampleDb

for /f "delims=" %%a IN ('dir /b /s *.sql') do call sqlcmd -S %server% -d %database%  -i %%~sdpnxa
