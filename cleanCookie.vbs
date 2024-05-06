Set objShell = CreateObject("WScript.Shell")
objShell.Run "taskkill /F /IM ""Rscript.exe"" /T", 0, True
