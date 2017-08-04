PowerShell says get-help about_signing
You change PowerShell's default security level

Try typing this:
 Set-ExecutionPolicy RemoteSigned -Scope Process 

or

Modify registry
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell
 set ExecutionPolicy : RemoteSigned
