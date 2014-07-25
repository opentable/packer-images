
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x32" > NUL && set OS=32BIT || set OS=64BIT

if %OS%==64BIT (
    if not exist "C:\Windows\Temp\7z920-x64.msi" (
        C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -Command "(New-Object System.Net.WebClient).DownloadFile('http://downloads.sourceforge.net/sevenzip/7z920-x64.msi', 'C:\Windows\Temp\7z920-x64.msi')" <NUL
    )
    echo "Installing 64-bit 7-zip"
    msiexec /qb /i C:\Windows\Temp\7z920-x64.msi
) else (
    if not exist "C:\Windows\Temp\7z920.msi" (
         C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -Command "(New-Object System.Net.WebClient).DownloadFile('http://downloads.sourceforge.net/sevenzip/7z920.msi', 'C:\Windows\Temp\7z920.msi')" <NUL
    )
    echo "Installing 32-bit 7-zip"
    msiexec /qb /i C:\Windows\Temp\7z920.msi
)

ping 127.0.0.1 -n 10 -w 1000 > NUL

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

cmd /c ""C:\Program Files\7-Zip\7z.exe" x "C:\Windows\Temp\windows.iso" -oC:\Windows\Temp\VMWare"
cmd /c C:\Windows\Temp\VMWare\setup.exe /S /v"/qn REBOOT=R\"

goto :done

:virtualbox

:: There needs to be Oracle CA (Certificate Authority) certificates installed in order
:: to prevent user intervention popups which will undermine a silent installation.
cmd /c certutil -addstore -f "TrustedPublisher" A:\oracle-cert.cer
ping 127.0.0.1 -n 10 -w 1000 > NUL

move /Y "C:\Users\vagrant\VBoxGuestAdditions.iso" C:\Windows\Temp
echo "fu"
echo "Extracting guest additions iso"
if %OS%==64BIT (
  cmd /c ""C:\Program Files\7-Zip\7z.exe" x C:\Windows\Temp\VBoxGuestAdditions.iso -oC:\Windows\Temp\virtualbox"
) else (
  echo "lbennett here"
)
echo "bar"
ping 127.0.0.1 -n 50 -w 1000 > NUL

echo "Installing guest additions"
cmd /c C:\Windows\Temp\virtualbox\VBoxWindowsAdditions.exe /S
ping 127.0.0.1 -n 10 -w 1000 > NUL

goto :done

:done

echo "Uninstalling 7-zip"
if %OS%==64BIT (
    msiexec /qb /x C:\Windows\Temp\7z920-x64.msi
) else (
    msiexec /qb /x C:\Windows\Temp\7z920.msi
)

ping 127.0.0.1 -n 10 -w 1000 > NUL
