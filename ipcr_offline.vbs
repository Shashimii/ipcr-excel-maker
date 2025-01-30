' IPCR EXCEL MAKER LOCALHOST ENVIROMENT AUTORUN
' © Shashimii https://github.com/Shashimii

' Modify dirctory & debug if its not working properly

Set WshShell = CreateObject("WScript.Shell")

' Function to check if a process is running
Function IsProcessRunning(processName)
    Dim objWMIService, colProcessList, objProcess
    Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
    Set colProcessList = objWMIService.ExecQuery("Select * from Win32_Process")
    
    For Each objProcess In colProcessList
        If InStr(objProcess.Name, processName) > 0 Then
            IsProcessRunning = True
            Exit Function
        End If
    Next
    IsProcessRunning = False
End Function

' Check if any of the services are running
If IsProcessRunning("httpd.exe") Or IsProcessRunning("mysqld.exe") Or IsProcessRunning("php.exe") Or IsProcessRunning("node.exe") Then
    ' If any service is running, show a popup with the link
    WshShell.Popup "Try Searching the Link below on your Browser:" & vbCrLf & "http://localhost:8080/#/", 60, "IPCR Excel Maker is Already Running", 64
    WScript.Quit
End If

' If no services are running, start them
' Start Apache
WshShell.Run "C:\xampp\apache_start.bat", 0, False

' Start MySQL
WshShell.Run "C:\xampp\mysql_start.bat", 0, False

' Start Laravel API server
WshShell.Run "cmd /c cd /d C:\code\ipcr-excel-maker\api && php artisan serve", 0, False

' Start Vue.js frontend
WshShell.Run "cmd /c cd /d C:\code\ipcr-excel-maker\frontend && npm run serve", 0, False

' Wait a moment for the services to start
WScript.Sleep 7000  ' Wait for 7 seconds

' Check if all services are running now
If IsProcessRunning("httpd.exe") And IsProcessRunning("mysqld.exe") And IsProcessRunning("php.exe") And IsProcessRunning("node.exe") Then
    ' If all services are running, open the website in the browser
    WshShell.Run "http://localhost:8080/#/", 1, False
    ' Show a message box and close it after 4 seconds
    WshShell.Popup "Opening IPCR Excel Maker...", 4, "Status", 64
Else
    ' Retry if services are not running yet
    WshShell.Popup "Retrying to Open IPCR Excel Maker...", 5, "Status", 64
    ' Wait a moment for the services to start
    WScript.Sleep 5000  ' Wait for 5 seconds
    
    ' Check again if all services are running
    If IsProcessRunning("httpd.exe") And IsProcessRunning("mysqld.exe") And IsProcessRunning("php.exe") And IsProcessRunning("node.exe") Then
        ' If all services are running, open the website in the browser
        WshShell.Run "http://localhost:8080/#/", 1, False
        ' Show a message box and close it after 4 seconds
        WshShell.Popup "Opening IPCR Excel Maker...", 4, "Status", 64
    Else
        ' Show a message if services are still not running
        WshShell.Popup "Startup Failed. Please contact developer.", 4, "Error", 48
    End If
End If






' ' DEBUG MODE

' Set WshShell = CreateObject("WScript.Shell")

' ' Function to check if a process is running
' Function IsProcessRunning(processName)
'     Dim objWMIService, colProcessList, objProcess
'     Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
'     Set colProcessList = objWMIService.ExecQuery("Select * from Win32_Process")
    
'     For Each objProcess In colProcessList
'         If InStr(objProcess.Name, processName) > 0 Then
'             IsProcessRunning = True
'             Exit Function
'         End If
'     Next
'     IsProcessRunning = False
' End Function

' ' Variable to accumulate messages if any services are running
' runningServices = ""

' ' Check if Apache is already running
' If IsProcessRunning("httpd.exe") Then
'     runningServices = runningServices & "Apache is already running." & vbCrLf
' End If

' ' Check if MySQL is already running
' If IsProcessRunning("mysqld.exe") Then
'     runningServices = runningServices & "MySQL is already running." & vbCrLf
' End If

' ' Check if Laravel API server is already running (replace 'php.exe' with the correct process if needed)
' If IsProcessRunning("php.exe") Then
'     runningServices = runningServices & "Laravel API is already running." & vbCrLf
' End If

' ' Check if Vue.js frontend server is already running (replace 'npm.exe' or the relevant process if needed)
' If IsProcessRunning("node.exe") Then
'     runningServices = runningServices & "Vue.js is already running." & vbCrLf
' End If

' ' runningServices = runningServices & "Try Searching the Link below on your Browser:" & vbCrLf
' ' runningServices = runningServices & "http://localhost:8080/#/" & vbCrLf

' ' If any service is running, show a single popup
' If Len(runningServices) > 0 Then
'     WshShell.Popup runningServices, 60, "IPCR Excel Maker is Already Runnng", 64
'     WScript.Quit
' End If

' ' Start Apache
' WshShell.Run "C:\xampp\apache_start.bat", 0, False

' ' Start MySQL
' WshShell.Run "C:\xampp\mysql_start.bat", 0, False

' ' Start Laravel API server
' WshShell.Run "cmd /c cd /d C:\code\ipcr-excel-localhost\api && php artisan serve", 0, False

' ' Start Vue.js frontend
' WshShell.Run "cmd /c cd /d C:\code\ipcr-excel-localhost\frontend && npm run serve", 0, False

' ' Show a message box and close it after 3 seconds
' WshShell.Popup "Opening IPCR Excel Maker...", 6, "Status", 64

' ' Wait for 5 seconds before opening the browser
' WScript.Sleep 5000

' ' Open the website in the default browser
' WshShell.Run "http://localhost:8080/#/", 1, False
