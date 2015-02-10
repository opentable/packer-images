
IF "%1%"=="win2008_64" (
   timeout 20 > null
   IF NOT EXIST "C:\Windows6.0-KB968930-x64.msu" (
     ECHO "Downloading Powershell 2.0"
     C:\Windows\System32\cscript.exe a:\downloadFile.vbs "http://download.microsoft.com/download/2/8/6/28686477-3242-4E96-9009-30B16BED89AF/Windows6.0-KB968930-x64.msu" "C:\Windows6.0-KB968930-x64.msu"
     timeout 10 > null
     ECHO "Installing Powershell 2.0"
     C:\Windows\System32\wusa.exe C:\Windows6.0-KB968930-x64.msu /quiet /norestart
   )
) ELSE IF "%1%"=="win2008" (
  timeout 20 > null
  IF NOT EXIST "C:\Windows6.0-KB968930-x86.msu" (
    ECHO "Downloading Powershell 2.0"
    C:\Windows\System32\cscript.exe a:\downloadFile.vbs "http://download.microsoft.com/download/F/9/E/F9EF6ACB-2BA8-4845-9C10-85FC4A69B207/Windows6.0-KB968930-x86.msu" "C:\Windows6.0-KB968930-x86.msu"
    timeout 10 > null
    ECHO "Installing Powershell 2.0"
    C:\Windows\System32\wusa.exe C:\Windows6.0-KB968930-x86.msu /quiet /norestart
  )
) ELSE IF "%1%"=="winVista_64" (
   timeout 20 > null
   IF NOT EXIST "C:\Windows6.0-KB936330-X64-wave0.exe" (
     ECHO "Downloading SP1"
     C:\Windows\System32\cscript.exe a:\downloadFile.vbs "http://download.microsoft.com/download/8/3/b/83b8c814-b000-44a4-b667-8c1f58727b8b/Windows6.0-KB936330-X64-wave0.exe" "C:\Windows6.0-KB936330-X64-wave0.exe"
     timeout 10 > null
     ECHO "Installing SP1"
     C:\Windows6.0-KB936330-X64-wave0.exe /quiet /norestart
     timeout 20 > null
   )
   IF NOT EXIST "C:\Windows6.0-KB968930-x64.msu" (
     ECHO "Downloading Powershell 2.0"
     C:\Windows\System32\cscript.exe a:\downloadFile.vbs "http://download.microsoft.com/download/2/8/6/28686477-3242-4E96-9009-30B16BED89AF/Windows6.0-KB968930-x64.msu" "C:\Windows6.0-KB968930-x64.msu"
     timeout 10 > null
     ECHO "Installing Powershell 2.0"
     C:\Windows\System32\wusa.exe C:\Windows6.0-KB968930-x64.msu /quiet /norestart
     timeout 20 > null
   )
) ELSE IF "%1%"=="win2003_64" (

   IF NOT EXIST "C:\WindowsServer2003.WindowsXP-KB914961-SP2-x64-ENU.exe" (
      ECHO "Downloading SP2"
      C:\Windows\System32\cscript.exe //X a:\downloadFile.vbs "http://download.microsoft.com/download/3/c/5/3c5c6364-27d3-4e18-bd04-244d0ec09dd4/WindowsServer2003.WindowsXP-KB914961-SP2-x64-ENU.exe" "C:\WindowsServer2003.WindowsXP-KB914961-SP2-x64-ENU.exe"

      C:\Windows\System32\reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v !Setup /t REG_SZ /d "C:\Windows\System32\cmd.exe /c a:\ps.bat win2003_64" /f

      ECHO "Installing SP2"
      C:\WindowsServer2003.WindowsXP-KB914961-SP2-x64-ENU.exe /quiet /norestart
   )

   IF NOT EXIST "C:\NetFx20SP1_x64.exe" (
     ECHO "Downloading .NET 2.0"
     C:\Windows\System32\cscript.exe //X a:\downloadFile.vbs "http://download.microsoft.com/download/9/8/6/98610406-c2b7-45a4-bdc3-9db1b1c5f7e2/NetFx20SP1_x64.exe" "C:\NetFx20SP1_x64.exe"

     ECHO "Installing .NET 2.0"
     C:\NetFx20SP1_x64.exe /q
   )

   IF NOT EXIST "C:\WindowsServer2003-KB968930-x64-ENG.exe" (

     ECHO "Downloading Powershell 2.0"
     C:\Windows\System32\cscript.exe //X a:\downloadFile.vbs "http://download.microsoft.com/download/B/D/9/BD9BB1FF-6609-4B10-9334-6D0C58066AA7/WindowsServer2003-KB968930-x64-ENG.exe" "C:\WindowsServer2003-KB968930-x64-ENG.exe"

     ECHO "Installing Powershell 2.0"
     C:\WindowsServer2003-KB968930-x64-ENG.exe /quiet /norestart

     a:\regedit.bat win2003_64

     timeout 20 > null
     shutdown /r /t 00
   )
) ELSE IF "%1%"=="win2003" (

  IF NOT EXIST "C:\WindowsServer2003-KB914961-SP2-x86-ENU.exe" (
    ECHO "Downloading SP2"
    C:\Windows\System32\cscript.exe //X a:\downloadFile.vbs "http://download.microsoft.com/download/5/f/1/5f104409-2736-48ef-82e1-692ec3da020b/WindowsServer2003-KB914961-SP2-x86-ENU.exe" "C:\WindowsServer2003-KB914961-SP2-x86-ENU.exe"

    C:\Windows\System32\reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v !Setup /t REG_SZ /d "C:\Windows\System32\cmd.exe /c a:\ps.bat win2003" /f

    ECHO "Installing SP2"
    C:\WindowsServer2003-KB914961-SP2-x86-ENU.exe /quiet /norestart
  )

  IF NOT EXIST "C:\NetFx20SP1_x86.exe" (
    ECHO "Downloading .NET 2.0"
    C:\Windows\System32\cscript.exe //X a:\downloadFile.vbs "http://download.microsoft.com/download/0/8/c/08c19fa4-4c4f-4ffb-9d6c-150906578c9e/NetFx20SP1_x86.exe" "C:\NetFx20SP1_x86.exe"

    ECHO "Installing .NET 2.0"
    C:\NetFx20SP1_x86.exe /q
  )

  IF NOT EXIST "WindowsServer2003-KB968930-x86-ENG.exe" (

    ECHO "Downloading Powershell 2.0"
    C:\Windows\System32\cscript.exe //X a:\downloadFile.vbs "http://download.microsoft.com/download/1/1/7/117FB25C-BB2D-41E1-B01E-0FEB0BC72C30/WindowsServer2003-KB968930-x86-ENG.exe" "WindowsServer2003-KB968930-x86-ENG.exe"

    ECHO "Installing Powershell 2.0"
    C:\WindowsServer2003-KB968930-x86-ENG.exe /quiet /norestart

    a:\regedit.bat win2003_64

    timeout 20 > null
    shutdown /r /t 00
  )

) ELSE (
  REM unsupported
)

timeout 20 > null
shutdown /r /t 00
