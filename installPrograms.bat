powershell.exe -ExecutionPolicy Bypass -Command "powershell.exe -File '%~dp0\installPrograms.ps1'" -Wait
powershell.exe -ExecutionPolicy Bypass -Command "Start-Process '%~dp0..\Ninite NET.exe'"
pause