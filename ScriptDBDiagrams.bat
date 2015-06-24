REM depends on sqlcmd which comes as part of ssms
REM connects to default instance on localhost by default

@echo off
Setlocal EnableDelayedExpansion
Setlocal EnableExtensions

if "!server!"==""   set server=.
if "!database!"=="" set database=ExampleDb

REM Usage:
REM * Powershell scripts must be enabled by running `Set-ExecutionPolicy RemoteSigned` as administrator in powershell. Answer Y at the prompt.

REM About:
REM * Reads diagrams from databases listed below and writes them out as sql files
REM * https://github.com/timabell/database-diagram-scm

powershell lib\ScriptDBDiagrams.ps1 -server %server% -database %database% -outputFolder "diagrams"
