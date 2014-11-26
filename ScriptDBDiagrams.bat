@echo off

REM Usage:
REM * Powershell scripts must be enabled by running `Set-ExecutionPolicy RemoteSigned` as administrator in powershell. Answer Y at the prompt.

REM About:
REM * Reads diagrams from databases listed below and writes them out as sql files
REM * https://github.com/timabell/database-diagram-scm

powershell lib\ScriptDBDiagrams.ps1 -server '(LocalDb)\v11.0' -database YourDatabase -outputFolder "diagrams"
