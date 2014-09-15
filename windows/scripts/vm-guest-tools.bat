set VIDEO=
for /f "tokens=2 delims==" %%a in ('wmic path win32_videocontroller Where DeviceID="VideoController1" get Description /value^|find "="') do @set VIDEO=%%a

Echo.%VIDEO% | find /i "VMware">Nul && (
  set PACKER_BUILDER_TYPE=vmware-iso
) || (
  set PACKER_BUILDER_TYPE=virtualbox-iso
)

if "%PACKER_BUILDER_TYPE%" equ "vmware-iso" goto :vmware
if "%PACKER_BUILDER_TYPE%" equ "virtualbox-iso" goto :virtualbox
goto :done

:vmware

cmd /c E:\setup.exe /S /v"/qn REBOOT=R\"

goto :done

:virtualbox
echo "Virtualbox install" >> C:\Windows\Temp\tools-install.txt

:: There needs to be Oracle CA (Certificate Authority) certificates installed in order
:: to prevent user intervention popups which will undermine a silent installation.
cmd /c certutil -addstore -f "TrustedPublisher" A:\oracle-cert.cer

cmd /c E:\VBoxWindowsAdditions.exe /S
goto :done

:done
