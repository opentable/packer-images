IF NOT EXIST "C:\Windows6.0-KB968930-x64.msu" (
  ECHO "Downloading Powershell 2.0"
  C:\Windows\System32\cscript.exe a:\downloadFile.vbs "http://download.microsoft.com/download/2/8/6/28686477-3242-4E96-9009-30B16BED89AF/Windows6.0-KB968930-x64.msu" "C:\Windows6.0-KB968930-x64.msu"
  timeout 10 > null
  ECHO "Installing Powershell 2.0"
  C:\Windows\System32\wusa.exe C:\Windows6.0-KB968930-x64.msu /quiet /norestart
)

timeout 20 > null
