' wmi.vbs'
' WMI-Abfrage in Visual Basic Script (VBScript)
set objWMI = GetObject("winmgmts:\\localhost\root\cimv2")
set disks = objWMI.ExecQuery("Select * from WIN32_LogicalDisk Where DriveType = 3")
for each disk in disks
  Ausgabe = disk.DeviceID& " " &disk.FreeSpace& " Kapazität"
  wscript.echo Ausgabe
Next