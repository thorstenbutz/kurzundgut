:: wmi1.cmd
:: WMI-Abfrage in der Eingabeauffordung
wmic.exe /node:sv1,sv2 path Win32_Logicaldisk where "drivetype=3" get DeviceID, Freespace
wmic.exe /node:sv1,sv2 Logicaldisk where "drivetype = 3" get DeviceID, Freespac