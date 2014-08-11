
A:\downloadFile.vbs "http://dl.bitvise.com/BvSshServer-Inst.exe" "C:\Windows\Temp\BvSshServer-Inst.exe"

C:\Windows\Temp\BvSshServer-Inst.exe -defaultSite -acceptEULA -activationCode=C9AAE0FE7C3743A71D891D5284F6F6BC6AAA6E842DDA03F5F72DA2C2B957BFA4CC4910E3572BB04B3AA919AD9B4B3AC97D4163161EA59BBC -settings=A:\BvSshServer-Settings.wst -startService
 
 IF "%1%"=="win2003_64" (
   cmd /c if exist %Systemroot%\system32\netsh.exe netsh firewall add allowedprogram name="Bitvise SSH Server" mode=ENABLE program="%SystemDrive%\Program Files\Bitvise SSH Server\BvSshServer.exe"
   cmd /c if exist %Systemroot%\system32\netsh.exe netsh firewall add portopening name="Bitvise SSH Server" mode=ENABLE protocol=TCP port=22
 ) ELSE (
   cmd /c if exist %Systemroot%\system32\netsh.exe netsh advfirewall firewall add rule name="Bitvise SSH Server" dir=in action=allow program="%SystemDrive%\Program Files\Bitvise SSH Server\BvSshServer.exe" enable=yes profile=ALL
   cmd /c if exist %Systemroot%\system32\netsh.exe netsh advfirewall firewall add rule name="Bitvise SSH Server" dir=in action=allow protocol=TCP localport=22
 ) 
