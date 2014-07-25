
REM enable remote desktop
%SystemRoot%\System32\reg.exe ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f

REM enable remote assistance
%SystemRoot%\System32\reg.exe ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fAllowToGetHelp /t REG_DWORD /d 1 /f
