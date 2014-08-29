reg.exe query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PROCESSOR_ARCHITECTURE | find /i "AMD64"
set BITNESS=%errorlevel%

if %BITNESS% EQU 0 (
    if not exist "C:\Windows\Temp\7z920-x64.msi" (
      a:\downloadFile.vbs "http://heanet.dl.sourceforge.net/project/sevenzip/7-Zip/9.20/7z920-x64.msi" "C:\Windows\Temp\7z920-x64.msi"
    )
    msiexec /qb /i C:\Windows\Temp\7z920-x64.msi
) else (
    if not exist "C:\Windows\Temp\7z920.msi" (
      a:\downloadFile.vbs "http://heanet.dl.sourceforge.net/project/sevenzip/7-Zip/9.20/7z920.msi" "C:\Windows\Temp\7z920.msi"
    )
    msiexec /qb /i C:\Windows\Temp\7z920.msi
)

if "%PACKER_BUILDER_TYPE%" equ "vmware-iso" goto :vmware
if "%PACKER_BUILDER_TYPE%" equ "virtualbox-iso" goto :virtualbox
goto :done

:vmware

if exist "C:\Users\vagrant\windows.iso" (
    move /Y C:\Users\vagrant\windows.iso C:\Windows\Temp
)

if not exist "C:\Windows\Temp\windows.iso" (
    C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -Command "(New-Object System.Net.WebClient).DownloadFile('http://softwareupdate.vmware.com/cds/vmw-desktop/ws/10.0.1/1379776/windows/packages/tools-windows-9.6.1.exe.tar', 'C:\Windows\Temp\vmware-tools.exe.tar')" <NUL
    cmd /c ""C:\Program Files\7-Zip\7z.exe" x C:\Windows\Temp\vmware-tools.exe.tar -oC:\Windows\Temp"
    FOR /r "C:\Windows\Temp" %%a in (tools-windows-*.exe) DO REN "%%~a" "tools-windows.exe"
    cmd /c C:\Windows\Temp\tools-windows
    move /Y "C:\Program Files (x86)\VMware\tools-windows\windows.iso" C:\Windows\Temp
    rd /S /Q "C:\Program Files (x86)\VMWare"
)

cmd /c ""C:\Program Files\7-Zip\7z.exe" x -y "C:\Windows\Temp\windows.iso" -oC:\Windows\Temp\VMWare"
cmd /c C:\Windows\Temp\VMWare\setup.exe /S /v"/qn REBOOT=R\"

goto :done

:virtualbox

:: There needs to be Oracle CA (Certificate Authority) certificates installed in order
:: to prevent user intervention popups which will undermine a silent installation.
cmd /c certutil -addstore -f "TrustedPublisher" A:\oracle-cert.cer

move /Y "C:\VBoxGuestAdditions.iso" C:\Windows\Temp

cmd /c ""C:\Program Files\7-Zip\7z.exe" x C:\Windows\Temp\VBoxGuestAdditions.iso -oC:\Windows\Temp\virtualbox"
cmd /c C:\Windows\Temp\virtualbox\VBoxWindowsAdditions.exe /S
goto :done

:done

if %BITNESS% EQU 0 (
    msiexec /qb /x C:\Windows\Temp\7z920-x64.msi
) else (
    msiexec /qb /x C:\Windows\Temp\7z920.msi
)
