powershell.exe -Command "Start-Process powershell.exe -NoNewWindow -ArgumentList 'Set-ExecutionPolicy RemoteSigned'"
powershell.exe -File "%~dp0\programs.ps1"
pause

