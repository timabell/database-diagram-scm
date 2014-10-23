@echo off
REM Reads diagrams from databases listed below and writes them out as sql files
REM Source: http://joelmansford.wordpress.com/2008/04/01/scripting-sql-server-diagrams-to-files-for-source-control/

REM  Powershell scripts must be enabled by running `Set-ExecutionPolicy RemoteSigned` as administrator in powershell. Answer Y at the prompt.
REM  You have to manually install the two .sql files in lib in each of the databases to be read for this to work.

powershell lib\ScriptDBDiagrams.ps1 -server '(LocalDb)\v11.0' -database YourDatabase -outputFolder "diagrams"

