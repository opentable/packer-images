
REM Show file extensions in Explorer
%SystemRoot%\System32\reg.exe ADD HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ /v HideFileExt /t REG_DWORD /d 0 /f

REM Enable QuickEdit mode
%SystemRoot%\System32\reg.exe ADD HKCU\Console /v QuickEdit /t REG_DWORD /d 1 /f

REM Show Run command in Start Menu
%SystemRoot%\System32\reg.exe ADD HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ /v Start_ShowRun /t REG_DWORD /d 1 /f

REM Show Administrative Tools in Start Menu
%SystemRoot%\System32\reg.exe ADD HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ /v StartMenuAdminTools /t REG_DWORD /d 1 /f

REM Zero Hibernation File
%SystemRoot%\System32\reg.exe ADD HKLM\SYSTEM\CurrentControlSet\Control\Power\ /v HibernateFileSizePercent /t REG_DWORD /d 0 /f

REM Disable Hibernation Mode
%SystemRoot%\System32\reg.exe ADD HKLM\SYSTEM\CurrentControlSet\Control\Power\ /v HibernateEnabled /t REG_DWORD /d 0 /f

REM disbaled firewall
Netsh firewall set opmode disable

echo rem >%Systemroot%\system32\chmod.cmd
