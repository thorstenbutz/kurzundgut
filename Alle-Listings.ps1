<#
  PowerShell kurz und gut, 5. Ausgabe, Januar 2021
  Alle Codelistings aus dem Buch, unkommentiert 
  (ohne druckbedingte Umbrüche)
#>

################################################################
## Kapitel 2: Hallo PowerShell
################################################################
## Seite 5
Get-Uptime
Get-FileHash -Path 'helloworld.ps1'
Test-Connection -TargetName 'www.oreilly.de' -TcpPort 80

Get-Uptime -since
Get-Process -Name 'pwsh'
Compress-Archive -Path '~/*' -DestinationPath 'backup.zip'

## Seite 6
nslookup www.oreilly.de
ping www.oreilly.de

42 + 23
60 * 60
7 % 2
'Power' + 'Shell'

[System.Net.Dns]::GetHostByName('www.oreilly.de')
[System.Net.Sockets.TcpClient]::new('188.40.159.226',80)

## Seite 7
Get-Process
Get-Process -Name 'pwsh'
Stop-Process -Name 'pwsh'

[System.Diagnostics.Process]::GetProcesses()
[System.Diagnostics.Process]::GetProcessesByName('pwsh').kill()

## Seite 8
Get-Command -Name 'Get-Process' | Select-Object -property CommandType, Name, Version, Source, DLL
Get-Command -CommandType 'Cmdlet'

## Seite 9
Get-Command -Name 'Compress-Archive'
Get-Command -Name 'Compress-Archive' | Select-Object -ExpandProperty Definition
Get-Command -CommandType 'Function'

Get-Command -Name 'Get-Process'
Get-Command -Name 'Get-Process' | Select-Object -Property *

## Seite 10
Get-Command -Name 'Get-Process' | Select-Object -Property *
Get-Command -Name 'Get-Process' | Select-Object -Property CommandType, Name, Version,Source, DLL

Get-Uptime
Get-Uptime | Select-Object -property *
Get-Uptime | Select-Object -property TotalHours

Get-Process -Name 'pwsh'
Get-Process -Name 'pwsh' | Select-Object -Property *
Get-Process -Name 'pwsh' | Select-Object -Property Processname, ID, Path

## Seite 11
Get-Process | Sort-Object -Property Handles -Descending | Select-Object -First 10
Get-Process -name 'pwsh' | Stop-Process -confirm
Get-ChildItem -Path $home -File -Recurse |Group-Object -Property Extension | Sort-Object -Property Count -Descending
Get-ChildItem -Path $home -File -Recurse | Measure-Object -Property Length -AllStats
Find-Module -Tag 'PSEdition_Core' | Measure-Object | Select-Object -ExpandProperty Count

# Seite 13
Get-Item -Path 'helloworld.ps1' | Select-Object -Property CreationTime, Fullname
Get-ChildItem -Path $home -file -Recurse | Select-Object -Property CreationTime, Fullname
Get-Process -Name 'pwsh' | Get-Member -MemberType Property
Get-Process -Name 'pwsh' |Select-Object -Property StartTime, Id, Processname, Path

################################################################
## Kapitel 3: Installieren und Aktualisieren der PowerShell
################################################################

## Seite 17
# Herunterladen des Installationsskripts:
Invoke-RestMethod -uri 'https://aka.ms/install-powershell.ps1' -UseBasicParsing -OutFile 'install-powershell.ps1'

# Systemweite Installation
.\install-powershell.ps1 -UseMSI -Quiet 

# Benutzerspezifische Installation
.\install-powershell.ps1 -Destination 'PS7' -AddToPath

# Installation der aktuellen Preview
.\install-powershell.ps1 -Quiet -UseMSI -Preview

winget install powershell

## Seite 18
choco install powershell-core
dotnet tool install --global PowerShell

<#  LINUX SHELL CODE

    # Herunterladen der GPG-Schlüssel für das Microsoft-Repository
    wget https://packages.microsoft.com/config/debian/10/packagesmicrosoft-prod.deb

    # Registrieren der GPG-Schlüssel
    dpkg -i packages-microsoft-prod.deb

    # Aktualisieren der Paketquellen
    apt-get update

    # Installation der PowerShell
    apt-get install -y powershell

    ## Seite 19
    # Start
    pwsh
 
    # Raspbian 9: Installation der PowerShell ohne Paketverwaltung
    # Erstellen des Programmverzeichnisses (Sie können auch einen anderen Ordner nutzen)
    mkdir -p /opt/powershell

    # Installation erforderlicher Pakete für das.NET Framework Core. Der reguläre Ausdruck 
    # stellt sicher, dass keine unnötigen Komponenten mitinstalliert werden.
    apt-get install '^libssl1.0.[0-9]$' libunwind8 -y

    # Download-URI ermitteln: Der grep-Suchfilter stellt sicher, dass wir nur den Download-Link
    # für ARM-32-Bit erhalten (als Einzeiler!).

    URI=$(curl -s https://api.github.com/repos/powershell/powershell/releases/latest | grep -oP '"browser_download_url": *"\K.*linux-arm32\.tar\.gz')

    # Herunterladen und Entpacken
    wget $URI
    tar -xvf ${URI##*/} -C ~/powershell

    # Erstellen eines symbolischen Links, um von jedem beliebigen Verzeichnis die PowerShell mittels "pwsh" aufrufen zu können
    ln -s /opt/powershell/pwsh /usr/bin/pwsh

    # Start der PowerShell
    pwsh

    ## Seite 20
    # Installation und Start des stabilen PowerShell-Release
    snap install powershell -classic
    pwsh

    # Entfernen von SNAP
    snap remove powershell

    # Alternative Installation der Preview
    snap install powershell-preview -classic
    pwsh-preview

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
#>

<#  MACOS SHELL CODE

    # Installation mittels Homebrew
    brew cask install powershell
    pwsh

    ## Seite 21

    # Aktualisierung mittels Homebrew
    brew update
    brew cask upgrade powershell
#>

## Seite 25
# Download des Installationsskripts
Install-Script -name 'Install-VSCode'

# Installation
Install-VSCode.ps1 -BuildEdition 'Stable-System'

<#  MACOS SHELL CODE
    brew cask install visual-studio-code
#>

## Seite 26
# Download-URI ermitteln
$uri = 'https://api.github.com/repos/microsoft/terminal/releases/latest'

# Herunterladen des MSIXBundle
Invoke-WebRequest -UseBasicParsing -Uri $uri -OutFile $uri.Split('/')[-1]

# Installation des Pakets für alle Benutzer
Add-AppxProvisionedPackage -SkipLicense -Online -PackagePath $uri.Split('/')[-1]

## Seite 26
# Download-URI ermitteln
$latest = 'https://api.github.com/repos/microsoft/terminal/releases/latest'
$uri = (Invoke-RestMethod -UseBasicParsing -Uri $latest).assets.browser_download_url[0]

# Herunterladen des MSIXBundle
Invoke-WebRequest -UseBasicParsing -Uri $uri -OutFile $uri.Split('/')[-1]

# Installation des Pakets für alle Benutzer
Add-AppxProvisionedPackage -SkipLicense -Online -PackagePath $uri.Split('/')[-1]

################################################################
## Kapitel 4: Das Hilfesystem
################################################################

## Seite 27
Get-Command -Noun *ipconfig*
Get-Command -Name *ipconfig*

## Seite 28
# Aktualisieren der Hilfe für den aktuellen Benutzer
Update-Help -UICulture en-US

# Aktualisieren der Hilfe für alle Benutzer
Update-Help -UICulture en-US -Scope AllUsers

# Ignorieren des 24h-Limits
Update-Help -UICulture en-US -Scope AllUsers -force

# Bereitstellen der Hilfe
Save-Help -DestinationPath '\\sv1\public\pshelp'

# Aktualisieren der Hilfe mithilfe einer Freigabe
Update-Help -UICulture en-US -Scope AllUsers -SourcePath '\\sv1\public\pshelp'

## Seite 29
Get-Help -name Get-Item

## Seite 30
# Parameter Set "Path"
Get-Item -Path ~ -Force

# Parameter Set "LiteralPath"
Get-Item -LiteralPath ~ -Force

## Seite 31
# Der Parameter "-Path": positional
Get-Item -Path 'install-powershell.ps1'
Get-Item 'install-powershell.ps1'

# "-Path" akzeptiert mehrere Pfadangaben (Array)
Get-Item -Path 'install-powershell.ps1','install-vscode.ps1'
Get-Item 'install-powershell.ps1','install-vscode.ps1'

Get-Help -Name 'Get-Item' -Detailed
Get-Help -Name 'Get-Item' -Full
Get-Help -Name 'Get-Item' -Parameter 'path'
Get-Help -Name 'Get-Item' -Examples
Get-Help -Name 'Get-Item' -Online

# Seitenweise Ausgabe
Get-Help -Name 'Get-Item' -Full | more
help -Name 'Get-Item'
help 'Get-Item'

## Seite 32
Get-Help -name Get-Item -examples

## Seite 33
# Alle PS1-Dateien
Get-Item -Path '*.ps1'

# Alle PS1-Dateien mit exakt drei Zeichen vor dem Punkt
Get-Item -Path '???.ps1'

# Alle PS1-Dateien, die mit A oder B oder C beginnen (unter Missachtung der Groß/Kleinschreibung)
Get-Item -Path '[abc]*.ps1'
Get-Item -Path '[a-c]*.ps1'

# Eine problematische Testdatei erzeugen.
New-Item -ItemType File -Path 'Präsentation [23.5.].pptx'

# Dies wird die soeben erzeugte Datei nicht auflisten.
Get-Item -Path 'Präsentation [23.5.].pptx'

# Diese Varianten sind erfolgreich.
Get-Item -LiteralPath 'Präsentation [23.5.].pptx'
Get-Item -Path 'Präsentation `[23.5.`].pptx'

Get-Help -Name about*
Get-Help -Name about_Wildcards
help about_regular_Expressions

################################################################
## Kapitel 5: Die Grundlagen der PowerShell
################################################################
## Seite 36
# Beispiel 1
Set-Location -Path $PSHOME
cd $PSHOME

# Beispiel 2
Get-ChildItem -Path $home -file -Recurse
dir $home -file -r

# Beispiel 3
Invoke-RestMethod -Uri 'http://ipinfo.io/188.40.159.226/json'
irm 'http://ipinfo.io/188.40.159.226/json'

## Seite 37
# Aliasse finden
Get-Alias
Get-Alias -Name *dir*
Get-Alias -Definition Get-ChildItem

# Einen neuen Alias definieren
New-Alias -Name up -Value Get-Uptime

# Beispiel 1
Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 10
gps | Sort-Object CPU -d | select -f 10
gps | sort CPU -d | select -f 10 # nur unter Windows

# Beispiel 2
Get-ChildItem -Force -Recurse | Format-Table -Property Length, Fullname -AutoSize
gci -fo -r | ft Length, Fullname -a

## Seite 38
# Beispiel 3
Get-ChildItem -path $home\*.mp3 -recurse | Measure-Object -Property Length -AllStats
dir $home\*.mp3 -r | measure length -al

Get-Command -Name timezone, verb, childitem, random

## Seite 39
# Linux, beliebige Shell
service --status-all
service cups status
service cups start
service cups stop
service cups restart

# Windows, beliebige Shell
sc.exe query
sc.exe query Spooler
sc.exe start Spooler
sc.exe stop Spooler
sc.exe stop Spooler && sc.exe start Spooler

# Windows, PowerShell
Get-Service
Get-Service -Name Spooler
Start-Service -Name Spooler
Stop-Service -Name Spooler
Restart-Service -Name Spooler
Get-Service -Name Spooler | Restart-Service

## Seite 41
# Ein System.TimeSpan-Objekt
Get-Member -InputObject (Get-Uptime)
Select-Object -InputObject (Get-Uptime) -Property Days, Hours, Minutes

# Abfrage der öffentlichen IP
Invoke-RestMethod -Uri 'ipinfo.io/json'
Get-Member -InputObject (Invoke-RestMethod -Uri 'ipinfo.io/json')
Select-Object -InputObject (Invoke-RestMethod -Uri 'ipinfo.io/json') -Property city, ip

## Seite 42
# DNS-Abfrage (nur Windows)
Resolve-DnsName -Name 'oreilly.de'
Get-Member -InputObject (Resolve-DnsName -Name 'oreilly.de')
Select-Object -InputObject (Resolve-DnsName -Name 'oreilly.de') -ExpandProperty IPAddress

# Abfragen des/der Standard-Gateway(s) (nur Windows)
Get-NetRoute -DestinationPrefix '0.0.0.0/0' 
Get-Member -InputObject (Get-NetRoute -DestinationPrefix '0.0.0.0/0')
Select-Object -InputObject (Get-NetRoute -DestinationPrefix '0.0.0.0/0') -ExpandProperty NextHop

## Seite 43
# Ein lokales Laufwerk erstellen
New-PsDrive -Name 'data' -PsProvider FileSystem -Root 'C:\data'
Set-Location -path 'data:'

## Seite 44
# Eine Freigabe verbinden
New-PsDrive -Name 'z' -PsProvider FileSystem -Root '\\sv1\data' -Persist
New-SmbMapping -LocalPath Z: -RemotePath '\\sv1\data' -persistent
Get-Process -name explorer | Stop-Process

## Seite 45
# Das "Laufwerk" env:
Set-Location -path 'env:'
Get-ChildItem

# Das Präfix $env
$env:PATH
$env:PSModulePath

# Standarddarstellung
Get-Item -Path 'helloworld.ps1'

# Auswahl der Eigenschaften mit Select-Object
Get-Item -Path 'helloworld.ps1' | Select-Object -Property Mode, CreationTime, LastWriteTime, Length, Name

## Seite 46
# Beispiel 1
Get-Item -Path 'helloworld.ps1' | Select-Object -Property Mode, CreationTime, LastWriteTime, 
Length, Name | Format-Table -Autosize

# Beispiel 2
Get-Item -Path 'helloworld.ps1' | Format-Table -Property Mode, CreationTime, LastWriteTime, Length, Name -Autosize

# Beispiel 3
Get-Item -Path 'helloworld.ps1' | Format-List -Property CreationTime, FullName

# Beispiel 4
Get-Item -Path '*.ps1' | Format-Wide -Property FullName

# Ausgabe im JSON-Format
Get-Item -Path '*.ps1'| Select-Object -Property Mode, CreationTime, LastWriteTime, Length, Name | ConvertTo-Json

# Ausgabe in einer grafischen Konsole (nur Windows)
Get-Item -Path '*.ps1'| Select-Object -Property Mode, CreationTime, LastWriteTime, Length, Name | Out-GridView

# Vorsicht, Falle: Dies erzeugt nicht das gewünschte Ergebnis!
Get-Item -Path '*.ps1'| Format-Table -Property Mode, CreationTime, LastWriteTime, Length, Name | ConvertTo-Json

## Seite 47
# Vorsicht, Falle: Out-GridView nimmt keine 
# Formatdaten entgegen (nur Windows)!
Get-Item -Path '*.ps1'| Format-Table -Property Mode, CreationTime, LastWriteTime, Length, Name | Out-GridView

# Literal strings
'Hallo Welt!'
'Hallo ' + 'Welt!'
'Test`n`t $ENV:PATH'

# Expandable strings
"Mein Heimatverzeichnis: $home"
"Test`n`t $ENV:PATH"

## Seite 48
# Entwerten von Sonderzeichen
"Der Inhalt der Variable `$home lautet: $home"
'Einfache Anführungsszeichen: ''Single Quotes'''
"Doppelte Anführungsszeichen: ""Single Quotes"""

# Here-string: literal
@'
Dieser Text wird wortwörtlich ausgegeben:
`t `n ""TEST"" @'
'@

# Here-string: expandable
@"
Heimatverzeichnis:
$home
"@

# Dies ist ein einzeiliger Kommentar!
<#
Dies ist ein mehrzeiliger
Kommentar!
#>

## Seite 49
$name = 'Thorsten'
$zahl = 5
${beliebige!@#@#`{Var`}iable} = 'PowerShell'

# Eine Zeichenkette: String
$name = 'Thorsten'
Get-Member -InputObject $name
$name.GetType()

# Eigenschaften eines Strings
$name.length

# Methoden eines Strings
$name.ToUpper()
$name.Substring(0,3)

# Strong typing
[int] $i = 1
$i = 'test' # Dies wird fehlschlagen!
$i.gettype()
$i = 2

# Eingabe validieren
try {
    [int] $eingabe = Read-Host -Prompt 'Geben Sie eine Zahl ein'
}
catch {
    'Fehlerhafte Eingabe'
}


## Seite 50
[System.Int32] 42
[System.Net.IPAddress] '1.1.1.1'

$ip = [System.Net.IPAddress] '1.1.1.1'
$ip.MapToIPv6() # Konvertiert die Adresse gemäß RFC 4291

[System.Int32] (10/9)

## Seite 51
# Datentyp und Type Accelerator
[System.Int32] 42
[int] 42
[System.Net.IPAddress] '1.1.1.1'
[ipaddress] '1.1.1.1'

# Vom Pseudonym zum vollständigen Namen
[int].FullName
[ipaddress].FullName

[System.Management.Automation.PSObject].Assembly.GetType('System.Management.Automation.TypeAccelerators')::get

# Etwas kürzer (mit einem Type Accelerator)
[psobject].Assembly.GetType('System.Management.Automation.TypeAccelerators')::get

# Type Accelerator erzeugen
[psobject].Assembly.GetType('System.Management.Automation.TypeAccelerators')::Add('tcpclient', [System.Net.Sockets.TCPClient])

# Type Accelerator verwenden
[tcpclient]::New('1.1.1.81',53)

## Seite 52
# Ein Array-Objekt
$dateien = Get-ChildItem -Path $home -file -Recurse
$dateien.count # Anzahl der gefundenen Dateien
Get-Member -InputObject $dateien
$dateien.GetType()

# Ein FileInfo-Objekt
$dateien[0].GetType()

# String-Array
$neffen = 'Tick','Trick','Track'
$neffen[1] # String: 'Trick'

# Integer-Array
$zahlen = 1..10
$zahlen[-1] # Das letzte Element, hier: 10

# Polymorphic/Mixed Arrays
$mix1 = 1,'Tick',$true
$mix2 = @() # Ein leeres Array initialisieren
$mix2 += $dateien += $neffen += $zahlen

$zahlen[0,2] # liefert das erste und das dritte Element zurück: 1, 3
$zahlen[1..4] # liefert das zweite bis fünfte Elemente zurück: 2, 3, 4, 5
$zahlen[-1..-2] # liefert die beiden letzten Elemente in absteigender Reihenfolge zurück: 10, 9
$zahlen[-1..2] # liefert das letzte Element zurück, springt an den Anfang und liefert die ersten drei Elemente: 10, 1, 2, 3

## Seite 53
$zahlen[,0+2..4+6] # liefert das erste Element, das dritte bis fünfte sowie das siebte Element: 1, 3, 4, 5, 7

$neffen = ,'Tick'

$zahl = 42
$zahl.count # Pseudo-Array
$zahl += 23 # $zahl repräsentiert nun 65
$myArray = ,42
$myArray.count
$myArray += 23 #
$myArray # repräsentiert nun 42,23

## Seite 54
[System.Collections.ArrayList]$al = @()
$al.add('Tick')
$al.add('Trick')
$al.add('Track')
$al[0] # String: Tick

# Allgemeine Form: Schlüsselname/Wert
$hashtable = @{ key = 'value'}

# Beispiel
$neffe = @{
  vorname = 'Tick'
  nachname = 'Duck'
  wohnort = 'Entenhausen'
}
$neffe.vorname

$neffe['givenname'] = 'Huey'
$neffe.Add('city','Ducktown')

## Seite 55
# Splatting mittels einer Hash Table
$parameters = @{
  Filter='*.ps1'
  Path=$HOME
  Recurse=$true
}
Get-ChildItem @parameters

################################################################
## Kapitel 6: Operatoren
################################################################

## Seite 59
'Tick','Trick','Track' -like 'tr*' # Antwort: Trick

'Tick','Trick','Track' -contains 'trick' # Antwort: True

'trick' -in 'Tick','Trick','Track' # Antwort: True

################################################################
## Kapitel 7: Flusskontrolle
################################################################

## Seite 61
# Beispiel 1: eine einfache Verzweigung
$zahl = 1
if ($zahl -gt 10) {'Erfolg'} else {'Misserfolg'}

## Seite 62
# Beispiel 2: die vereinfachte Schreibweise mittels "Ternary Operator"
$zahl -gt 10 ? 'Erfolg' : 'Misserfolg'

# Beispiel 3: Gesetzt den Fall, Sie haben keine *.abc-Datei im aktuellen Verzeichnis, lautet das Ergebnis: 1.
if (Get-ChildItem -Filter *.abc) {1} {2}

# Beispiel 1: Ergebnis 2
switch (10) {
     9 {1}
    10 {2}
    11 {3} 
## Seite 63
    12 {4}
    Default {5}
}

# Beispiel 2: Ergebnis 3, 4
switch (10) {
    { 9 -gt $_} {1}
    {10 -gt $_} {2}
    {11 -gt $_} {3}
    {12 -gt $_} {4}
    Default {5}
}

# Beispiel 3: Ergebnis 3
switch (10) {
    { 9 -gt $_} {1}
    {10 -gt $_} {2}
    {11 -gt $_} {3; break}
    {12 -gt $_} {4}
    Default {5}
}

# Beispiel 4: Ergebnis 3,4
switch (10,11) {
    { 9 -gt $_} {1}
    {10 -gt $_} {2}
    {11 -gt $_} {3; continue}
    {12 -gt $_} {4}
    Default {5}
}

## Seite 64
# Beispiel 5: Ergebnis 1
switch -wildcard ('powershell') {
    'p*' {1}
    'x*' {2}
    'y*' {3}
    'z*' {4}
    Default {5}
}

# Beispiel 6: Ergebnis 1,2,3,4
switch -regex ('powershell') {
    'p' {1}
    '.' {2}
    'p*' {3}
    '\w' {4}
    Default {5}
}

## Seite 65
# Eine for-Schleife mit Schrittweite 2: Ergebnis 1,3,5,7
for ($i = 1; $i -lt 9; $i+=2 ) {
    $i
}

# Zahlen addieren: Ergebnis 55
foreach ($i in 1..10) {
    $summe += $i
}
$summe

## Seite 66
# Kopfgesteuerte Schleife, gibt die Zahlen 1 bis 10 aus.
while ($i -lt 10) {
    $i++
    $i
}

# Fußgesteuerte Schleife, gibt die Zahlen 1 bis 10 aus.
do {
    $i++
    $i
} while ($i -lt 10)

# Fußgesteuerte Schleife, gibt die Zahl 1 aus.
do {
    $i++
    $i
} until ($i -lt 10)

## Seite 67
# Beispiel 1, Ausgabe: a
foreach($item in 'a','b','c') {
    if ($item -eq 'b') {break}
    $item
}

# Beispiel 2, Ausgabe: 2 a c 3 a c 4 a c
$i = 1
while ($i -lt 4) {
    $i++
    $i
    foreach($item in 'a','b','c') {
        if ($item -eq 'b') {continue}
        $item
    }
}

# Beispiel 3, Ausgabe: 1 a
:outer_loop while ($i -lt 4) { # Label: outer_loop
    $i++
    $i
    :inner_loop foreach($item in 'a','b','c') { # Label: inner_loop
        if ($item -eq 'b') {break outer_loop}
        $item
    }
}

################################################################
## Kapitel 8: Pipelining
################################################################

## Seite 69
# Beispiel 1
# Ein einzelner Wert wird an einen Parameter übergeben.
Get-Date -date '1961-04-12'

# Mehrere Werte werden über die Pipeline übergeben.
'1961-04-12','1969-07-21' | Get-Date

# Die Pipeline erweitern.
'1961-04-12','1969-07-21' | Get-Date |
  Select-Object -Property DayOfWeek
 
## Seite 71
# Beispiel 2
Import-Csv -Path 'missions.csv' | Get-Date |
Select-Object -Property DayOfWeek

# Beispiel 1: Ein externes Programm wird in die Pipeline eingebunden.
'www.oreilly.de','www.dpunkt.de' |
  ForEach-Object -Process { nslookup $_ }

# Beispiel 2: Der Alias % für ForEach-Object.
'www.oreilly.de','www.dpunkt.de' | % { nslookup $_ }

# Beispiel 3: Suche mithilfe des Active Directory (nur Windows).
Get-ADComputer -Filter * | ForEach-Object -Process {
    Test-Connection -ComputerName $_.DNSHostname -Count 1 -ErrorAction SilentlyContinue
}

## Seite 72
# Pipelining mit ForEach-Object
'Tick','Trick','Track' | ForEach-Object -process {
    "$_ ist ein Neffe von Donald!"
}

# Eine Schleife mit foreach
foreach ($neffe in 'Tick','Trick','Track') {
    "$neffe ist ein Neffe von Donald!"
}

## Seite 73
# Beispiel 1: Parallele Ausführung
'www.oreilly.de','www.dpunkt.de' | ForEach-Object -process {
    Test-Connection -ComputerName $_ -Count 4 -ErrorAction SilentlyContinue
}

# Beispiel 2: Zeit messen
Measure-Command -Expression {
    $count = 4
    'www.oreilly.de','www.dpunkt.de' |
    ForEach-Object -ThrottleLimit 2 -process {
        Test-Connection -ComputerName $_-Count $using:count -ErrorAction SilentlyContinue
    }
} | Select-Object -ExpandProperty TotalSeconds

## Seite 74
# Beispiel 1: Finde Dateien, die größer als 10 MB sind.
Get-ChildItem -Path ~ -File -Recurse | Where-Object -FilterScript { $_.Length -gt 10MB } | Sort-Object -Property Length -Descending

# Beispiel 2: Finde Dateien, die in den letzten 6 Monaten geändert wurden.
Get-ChildItem -Path ~ -File -Recurse | Where-Object -FilterScript { $_.LastWriteTime -gt (Get-Date).AddMonths(-6)}

# Beispiel 3: Finde Prozesse, die mehr als 42 s CPUZeit verbraucht haben.
Get-Process | Where-Object -FilterScript { $_.CPU -gt 42 } | Sort-Object -Property CPU -Descending

# Beispiel 4: Finde lokale Benutzer, deren SID auf "-500" endet (nur Windows).
Get-LocalUser | ? { $_.SID -like '*-500' } | Format-List -Property Name, Enabled, Description, SID 

# Beispiel 5: Prüfe die Erreichbarkeit (nur PowerShell 7)
'www.oreilly.de','www.dpunkt.de' | ? {
  Test-Connection -TargetName $_ -TcpPort 80
}

## Seite 75
# Erste Wahl
Get-ChildItem -path ~ -Filter '*.ps1'

# Zweite Wahl
Get-ChildItem -path ~ | Where-Object -FilterScript {
  $_.Extension -eq '.ps1'
}

## Seite 76
# Ersetzen des Eigenschaftsnamens
Get-Item -Path 'helloworld.ps1' | Select-Object -Property Mode, LastWriteTime, @{ Name='Size'; expression={$_.Length}}, Name

# Umrechnen in Kilobyte (KiB)
Get-Item -Path 'helloworld.ps1' | Select-Object -Property Mode, LastWriteTime, @{ Name='Size(KiB)'; expression={$_.Length/1024}}, Name

# Seite 77
# Weitergehende Anpassungen mit Format-Table
Get-Item -Path 'helloworld.ps1' | Format-Table -Property @{n='Size(KiB)';w=42; e={$_.Length/1024};f='N2';a='left'}, Mode, LastWriteTime, Name

# Formatierung mit dem Format-Operator
Get-Item -Path 'helloworld.ps1' |
Select-Object -Property Mode, LastWriteTime, @{
    n='Size(KiB)'
    e={'{0:N3}' -f ($_.Length/1024)}
}, Name


# Runden statt formatieren
Get-Item -Path 'helloworld.ps1' |
Select-Object -Property Mode, LastWriteTime, @{
    n='Size(KiB)'
    e={ [Math]::Round($_.Length/2,3)}
}, Name

################################################################
## Kapitel 9: Verwalten von Fehlern
################################################################

## Seite 80
# Beispiele für Nonterminating Errors
Get-ChildItem -Path 'gibtesnicht', $HOME | Select-Object -Property FullName
Get-Process -FileVersionInfo | Out-GridView # Nur Windows

## Seite 81
# Aus nonterminating wird terminating
Get-ChildItem -Path 'gibtesnicht',$HOME, $PSHOME -ErrorAction Stop | Select-Object -Property FullName
Get-Process -FileVersionInfo -ErrorAction Stop | Out-GridView # Nur Windows

# Beispiele für Terminating Errors
Get-ChildItem -gibtesnicht
1 / 0
Get-Date -Date '123ABC'

# Allgemeine Form: throw <Fehlermeldung>
# Ein Beispiel
throw 'Critcial error!' ; 'Dies wird nicht ausgeführt!'

## Seite 82
# Nonterminating Error
Write-Error -Message 'Critcial error!'

# Terminating Error
Write-Error -Message 'Critcial error!' -ErrorAction Stop

# Trap
trap { 'Vorsicht!' } 1/0

# Try/Catch/Finally
try {
    1
    1/0
    2
}
catch [DivideByZeroException] {
    'Sie haben versucht, durch 0 zu teilen!'
}
catch {
    "Ein unbekannter Fehler ist aufgetreten: $_"
}
finally {
    'Ende'
}

## Seite 83
# Ausnahmetyp ermitteln: $error
$error[0].Exception.GetType().Fullname
$error[0].Exception.InnerException.GetType().Fullname

# Ausnahmetyp ermitteln: Get-Error
(Get-Error).Exception.GetType().Fullname
(Get-Error).Exception.InnerException.GetType().Fullname

## Seite 84
# Einfache Umleitung (defaut = 1: Success)
Get-ChildItem -Path $HOME > 'files.txt'

# Dies ist äquilavent hierzu
Get-ChildItem -Path $HOME 1> 'files.txt'
Get-ChildItem -Path $HOME | Out-File -path 'files.txt'

# Erweitern einer Datei
Get-ChildItem -Path $PSHOME > 'files.txt'
Get-ChildItem -Path $PSHOME | Out-File -path 'files.txt' -append

# Fehler und Erfolge in verschiedene Dateien protokollieren
Get-ChildItem -Path 'gibtesnicht',
  $HOME 2> errors.txt > files.txt

# Fehler und Erfolge in einem Stream kombinieren
Get-ChildItem -Path 'gibtesnicht',
  $HOME 2>&1 > error-successlog.txt

# Alle Streams in eine Datei protokollieren
Get-ChildItem -Path 'gibtesnicht',$HOME *> all-streams-log.txt

# "Nicht sichtbare" Informationen erzeugen
Write-Information -MessageData (Get-Date)

# Information Stream in eine Datei umleiten
Write-Information -MessageData (Get-Date) 6> 'information.txt'

# Information Stream mit der Standardausgabe (Success) kombinieren
Write-Information -MessageData (Get-Date) 6>&1

## Seite 85
Get-Date | Write-Host -ForegroundColor Yellow

# Vorsicht, Falle: Dies funktioniert NICHT!
$date = Get-Date | Write-Host -ForegroundColor Yellow
Get-Date | Write-Host | Out-File -FilePath 'log.txt'

[Console]::WriteLine((Get-Date))

## Seite 86
'Hallo Welt!'
Write-Output -InputObject 'Hallo Welt!'

$result = Write-Host -Object (Get-Date) 6>&1
Write-Host -Object 'Hallo Welt!' 6> information.txt

################################################################
## Kapitel 10: Den Funktionsumfang der PowerShell erweitern
################################################################

## Seite 88
# Snap-ins auflisten in Windows PowerShell 1 bis 5
Get-PSSnapin
Get-PSSnapin -Registered

# Snap-ins laden in Windows PowerShell 1 bis 5: Add-PSSnapin -Name <Name>
Get-PSSnapin -Registered | Add-PSSnapin

# Die Ausgabe der PSModulePath-Variable 
# in PowerShell 7 unter Windows
$env:PSModulePath.split(';')

## Seite 89
# Module verwalten
Get-Module
Get-Module -ListAvailable

# Ein Modul explizit laden
Import-Module -Name Microsoft.PowerShell.Utility

# Ein (eigenes) Modul erneut laden, falls Änderungen am Programmcode erfolgt sind
Import-Module -Name '.\HalloWelt\' -force

## Seite 90
# Module-qualified names
Microsoft.PowerShell.Utility\Get-Uptime
Microsoft.PowerShell.Management\Get-Item -Path 'helloworld.ps1'

## Seite 92
# Installation der RSAT in Windows 10 v1809 und später
Get-WindowsCapability -Online -Name 'rsat.*'
Add-WindowsCapability -Online -Name 'Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0'

# Auswahl und Installation mittels Pipelining
Get-WindowsCapability -Online -Name rsat.* | Out-GridView -PassThru | Add-WindowsCapability -online

# Softwareverteilung: Module, Provider, Repositories
Get-Module -ListAvailable -Name PackageManagement, PowerShellGet
Get-PackageProvider
Get-PSRepository

## Seite 93
winget search vscode
winget install Microsoft.VisualStudioCode --exact

## Seite 94
# Windows PowerShell 5: Aktualisieren der Paketverwaltung
Install-PackageProvider Nuget -Force
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -Name PowerShellGet, PackageManagement -Force

# Installation eines Moduls aus der PSGallery
Find-Module -Name AzureAD
Install-Module -Name AzureAD -Scope AllUsers

## Seite 95
# Suche in der PSGallery: Module
Find-Module -Repository 'PSGallery' -Name 'PowerShellGet' -AllowPrerelease -AllVersions
Find-Module -Repository 'PSGallery' -Tag 'MacOS','PSEdition_Core'
Find-Module -Repository 'PSGallery' -Tag 'PSEdition_Core' -Name 'AWS*'
Find-Module -Command 'Out-ConsoleGridView' |Select-Object -ExpandProperty AdditionalMetadata

# Suche in der PSGallery: DSC-Ressourcen
Find-Module -Repository PSGallery -name '*ActiveDirectory' -Includes DscResource
Find-DscResource -Name xADDomain

# Suche in der PSGallery: Skripte
Find-Script -Repository 'PSGallery' -Name 'Install-*'
Find-Script -Name 'Install-VSCode' | Select-Object -ExpandProperty AdditionalMetadata

## Seite 97
# Bereitstellen
Install-Module -Name 'Microsoft.PowerShell.ConsoleGuiTools' -MaximumVersion 0.3.0 -Scope CurrentUser

# Aktualisieren
Update-Module -Name 'Microsoft.PowerShell.ConsoleGuiTools'

# Entfernen
Get-InstalledModule -Name 'Microsoft.PowerShell.ConsoleGuiTools' -AllVersions
Uninstall-Module -Name 'Microsoft.PowerShell.ConsoleGuiTools' -RequiredVersion 0.3.0

# Alle Module, die mittels Paketmanagement installiert wurden, "aktualisieren"
Get-InstalledModule | Update-Module

## Seite 98
New-Item -Path 'c:\ps'
New-Item -ItemType Junction -Path "$home\Documents\PowerShell" -Value 'C:\ps\'
New-Item -ItemType Junction -Path "$home\Documents\WindowsPowerShell" -Value 'C:\ps'

## Seite 99
# Für die Windows PowerShell 5: Ändern des Standardverhaltens
$PSDefaultParameterValues = @{
    'Install-Module:Scope'='CurrentUser'
    'Install-Script:Scope'='CurrentUser'
}

# Eine Freigabe erstellen (für Windows)
New-Item -ItemType Directory -Path 'C:\CompanyRepo' 
New-SmbShare -Path 'C:\CompanyRepo' -Name 'CompanyRepo' -ChangeAccess 'RepoAdmins' -ReadAccess 'RepoUsers'

# Eigenes Repository erzeugen, eigenes Modul veröffentlichen:
Register-PSRepository -Name 'CompanyRepo' -SourceLocation '\\sv1\CompanyRepo' -InstallationPolicy Trusted
Publish-Module -Path '.\MyModule' -Repository 'CompanyRepo'

################################################################
## Kapitel 11: Vom Skript zum Modul
################################################################

## Seite 101
Get-ExecutionPolicy -List

# Nur die effektiven auflisten
Get-ExecutionPolicy

Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser

## Seite 103
# Keine administrativen Rechte erforderlich 
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted

# Lokale administrative Rechte erforderlich
# Optional: -Scope LocalMachine -Force
Set-ExecutionPolicy -ExecutionPolicy AllSigned
 
pwsh.exe -executionPolicy ByPass -file 'skript.ps1'

## Seite 105
# ADS finden, einsehen und löschen
Get-Item -Path '.\install-powershell.ps1' -Stream *
Get-Item -Path '.\install-powershell.ps1' -Stream Zone.Identifier
Get-Content -Path '.\install-powershell.ps1' -Stream Zone.Identifier
Unblock-File -Path '.\install-powershell.ps1'

## Seite 106
$profile.AllUsersAllHosts
$profile.AllUsersCurrentHost
$profile.CurrentUserAllHosts
$profile.CurrentUserCurrentHost # (auch: $profile)

# Das Prompt anpassen
function prompt {
    $env:COMPUTERNAME + ' PS ' + $(Get-Location) +
    "$('>' * ($nestedPromptLevel + 1)) "
}

. $home\myprofile.ps1

# Einen HardLink erzeugen
New-Item -ItemType HardLink -Path 'C:\Program Files\PowerShell\7\profile.ps1' -Value 'C:\Windows\System32\WindowsPowerShell\v1.0\profile.ps1'

## Seite 107
# Ausführen einer Skriptdatei
c:\ps\myscript.ps1 # absolute Pfadangabe
.\myscript.ps1 # relative Pfadangabe

# der Call-Operator toleriert Leerschritte
& 'my script.ps1' 

## Seite 108
# Dot sourcing
. 'c:\ps\myscript.ps1' # absolute Pfadangabe
. '.\myscript.ps1' # relative Pfadangabe

## Seite 109
# Eine einfache Funktion
function mytop {
    param (
    [int] $Count = 10
    )
    Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First $Count
}
mytop -Count 5
 
## Seite 110
$results = mytop -Count 5

# Der Prozess mit dem höchsten CPU-Wert
$results[0]

## Seite 111
# Eine Advanced Function => ein Cmdlet
function ConvertFrom-UtcTime {         
    [CmdletBinding()]
    Param (
        [Parameter(
            Mandatory,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [DateTime] $Time
    )
    Begin {}
    Process {
        $utc = [System.TimeZoneInfo]::FindSystemTimeZoneById('UTC')
        $local = [System.TimeZoneInfo]::Local
        [System.TimeZoneInfo]::ConvertTime($time, $utc, $local)
    }
    End {}
}

# Das neue Cmdlet aufrufen
ConvertFrom-UtcTime -Time '1961-04-12 06:17'
'1969-07-21 02:56', '1961-04-12 06:17' | ConvertFrom-UtcTime

## Seite 112
# Ein eigenes Modul erstellen
$parameters = @{
    ModuleVersion = '0.1'
    PowerShellVersion = '5.0'
    CmdletsToExport = 'ConvertFrom-UtcTime'
    Author = 'Thorsten Butz'
    CompatiblePSEditions = 'Core','Desktop'
    RootModule = "$home\Documents\PowerShell\Modules\KurzUndGut\0.1\KurzUndGut.psm1"
    Path = "$home\Documents\PowerShell\Modules\KurzUndGut\0.1\KurzUndGut.psd1"
}
New-ModuleManifest @parameters

################################################################
## Kapitel 12: Eigene Datentypen und Klassen
################################################################

## Seite 115
# Drei Wege, ein Ergebnis
New-Object -TypeName System.DateTime -ArgumentList 1961,4,12
[System.DateTime]::new(1961,4,12)
Get-Date -Date 1961-4-12

## Seite 116
# Statische Eigenschaften und Methoden
[System.DateTime]::MaxValue
[System.Math]::PI
[System.Math]::Round(10/9,2)

# Eigenschaften und Methoden einer Instanz
$date = [System.DateTime]::Now
$date.DayOfWeek
$date.ToUniversalTime()

# Ein "PSCustomObject" erzeugen: Variante A
New-Object -TypeName PSCustomObject -Property @{GivenName='Grace';Surname='Hopper'}

## Seite 117
# Ein "PSCustomObject" erzeugen: Variante B
[PSCustomObject] @{GivenName='Hopper';Surname='Grace'}

# Eine "leere Hülle" nach und nach befüllen
$user = [PSCustomObject] @{}
Add-Member -InputObject $user -Name 'GivenName' -Value 'Alan' -MemberType NoteProperty
$user | Add-Member -Name 'Surname' -Value 'Turing' -MemberType NoteProperty

# Eine eigene Methode definieren
$user | Add-Member -MemberType ScriptMethod -Value {Get-Random} -name Random
$user.random()

# Eine Eigenschaft entfernen (selten benötigt)
$user.psobject.properties.remove('GivenName')

# FileInfo-Objekte erweitern: ScriptProperty
$file = Get-ChildItem -path 'helloworld.ps1'
$file | Add-Member -MemberType ScriptProperty -Name 'SizeInMiB' -Value {[math]::Round(($this.Length/1MB),2)}
$file | Select-Object -Property SizeInMiB,Length, Fullname
$file.SizeInMiB

# FileInfo-Objekte erweitern: ScriptMethod
$file | Add-Member -MemberType ScriptMethod -Name 'SizeToGiB' -Value {[math]::Round(($this.Length/1GB),4)}
$file.SizeToGiB()

## Seite 118
[Enum]::GetValues([Microsoft.PowerShell.ExecutionPolicy])

Enum Vendor {
    HP
    Dell
    IBM
    Lenovo
}

class Server {
    [string]$Computername
    [vendor]$Vendor
    [string]$Model
}

# Eine neue Instanz der Klasse Server erzeugen
$myserver = [server]::new()
$myserver.computername = 'sv1'
$myserver.Vendor = 'HP'
$myserver.Model = 'ProLiant'

# Alternative: PSCustomObject
$myserver = [PSCustomObject] @{
    Computername = 'sv1'
    Vendor = 'HP'
    Model = 'ProLiant'
}

## Seite 119
class Server {
    # Properties
    [string]$Computername
    [vendor]$Vendor
    [string]$Model
    [dateTime]$LastEchoReply
    # Methods
    [string]GetBasicInfo() {
        if ($this.LastEchoReply -eq 0) {
            return "$($this.Computername) (Last seen: never)"
        }
        else {
            return "$($this.Computername) (Last seen: 
              $($this.LastEchoReply))"
        }
    }
    [void]RunPingTest() {
        $this.LastEchoReply = $(
            if (Test-Connection $this.computername -Count 1 -Quiet)
            { Get-Date }
            else { Get-Date -Date 0 }
        )
    }
    # Constructor
    Server($computername) {
        $this.Computername = $Computername
        $this.RunPingTest()
    }
}

$myserver = [Server]::new('sv1')
$myserver.RunPingTest()
$myserver.GetBasicInfo()
$myserver.LastEchoReply

################################################################
## Kapitel 13: Reguläre Ausdrücke
################################################################

## Seite 121
# Beinhaltet "42" eine Zahl?
42 -match '\d' # TRUE

# Kurzform: [regex]
[System.Text.RegularExpressions.Regex]::Match(42,'\d')

## Seite 122
'Ken Thompson' -match 'k' # True
'Ken Thompson' -cmatch 'k' # False
[regex]::match('Ken Thompson','k') # False

## Seite 123
[regex]::Escape('.') # Ausgabe: \.

## Seite 124
42 -match '\d' # TRUE
$matches.0 # Ausgabe: 4

# Tabelle 13-3: Zeichenklassen 
# Alle Zeichen mit Ausnahme eines Newline.
'T' -match '.' # True
'' -match '.' # False

# Ein beliebiges Zeichen in eckigen Klammern.
'Test' -match '[tuv]' # True
'Test' -match '[xyz]' # False

#Ein beliebiges Zeichen, das sich nicht in den eckigen Klammern befindet.
'Test' -match '[^tuv]' # True
'Test' -match '[^tes]' # False

## Seite 125
# Alle Zeichen zwischen Start und Ende, jeweils inklusive. Sie können
# mehrere Zeichenbereiche in eckigen Klammern angeben.
'Test' -match '[t-v]' # True
'Test' -match '[u-w]' # False

# Alle Zeichen, die sich nicht zwischen Start und Ende befinden (inklusive).
# Sie können mehrere Zeichenbereiche in eckigen Klammern angeben.
42 -match '[^5-9][^5-9]' # True
42 -match '[^1-4][^1-4]' # False

## Seite 123
# Tabelle 13-2: Zeichenklassen  (Forsetzung)
# Alle Zeichen in der Unicode-Gruppe oder im Blockbereich, der durch die
# Zeichenklasse angegeben wird. Als Beispiel repräsentiert {Sm} mathematische
# Symbole.
'+' -match '\p{Sm}' # True
'!' -match '\p{Sm}' # False

# Alle Zeichen, die sich nicht in der Unicode-Gruppe oder im Blockbereich
# befinden, der durch Zeichenklasse angegeben wird. Als Beispiel repräsentiert
# {Sc} Währungssymbole.
'%' -match '\P{Sc}' # True
'€' -match '\p{Sc}' # False

# Jedes Wortzeichen, entspricht: [a-zA-Z_0-9].
'a' -match '\w' # True
'$' -match '\w' # False

# Jedes Nicht-Wortzeichen.
'!' -match '\W' # True
'1' -match '\W' # False

# Jedes Whitespace-Zeichen. Als Beispiel repräsentiert ´t einen Tabstopp.
# Vorsicht: Die Shell muss den Tabstopp interpretieren, deshalb
# sind linkerhand Double Quotes erforderlich.
"´t" -match '\s' # True
42 -match '\s' # False

# Jedes Nicht-Whitespace-Zeichen. Als Beispiel repräsentiert ´n eine
# neue Zeile (Newline).
'T e s t' -match '\S' # True
"`n" -match '\S' # False

# Jede Dezimalziffer.
42 -match '\d' # True
'/' -match '\d' # False

# Jede Nicht-Dezimalziffer.
'030-110' -match '\D' # True
'030110' -match '\D' # False

## Seite 126
(Get-Content -Path hosts) -notmatch '^#'

# Tabelle 13-4: Quantifizierer
# Keine, eine oder viele Übereinstimmung(en).
'TTTT' -match 't*' # true
'' -match 't*' # true

# Eine oder viele Übereinstimmung(en).
'TTTT' -match 't+' # true
'' -match 't+' # false

# Keine oder eine Übereinstimmung.
'TTTT' -match 't?' # true
'' -match 't?' # true

# Genau n Übereinstimmungen.
'TTTT' -match 't{4}' # true
'TTTT' -match 't{5}' # false

## Seite 127  (Tabelle 13-4 Fortsetzung )
# n oder mehr Übereinstimmungen.
'TTTT' -match 't{4,}' # true
'TTTT' -match 't{5,}' # false

# Zwischen n und m Übereinstimmungen (inklusive).
'TTTT' -match 't{4,6}' # true
'TTTT' -match 't{5,6}' # false

# Greedy: das Standardverhalten
'TTTT' -match 't+'
$Matches.0 # Ausgabe: TTTT
'TTTT' -replace 't+','U' # Ausgabe: U

# Lazy
'TTTT' -match 't+?'
$Matches.0 # Ausgabe: T
'TTTT' -replace 't+?','U' # Ausgabe: UUUU

## Seite 128
# Ohne Quantifizierer
'TTTT' -match 't'
$Matches.0 # Ausgabe: T
'TTTT' -replace 't','U' # Ausgabe: UUUU

'TTTT' -match '(T|42){2}' # True
'T42' -match '(T|42){2}' # True
'T4' -match '(T|42){2}' # False

## Seite 129 (Tabelle 13-5 Fortsetzung)
'Thompson,Ken' -match '\bKen' # True
'Thompson_Ken' -match '\bKen' # False

'ThompsonKen' -match '\bKen'

# Ersetzt alle Leerschritte durch einen Unterstrich.
'Dies ist ein Text' -replace '\s','_'

# Teilt die Zeichenfolge in ein String-Array auf.
'Dies ist ein Text' -split '\s'

# Windows: Ersetze 2+ Whitespaces durch ein Komma.
(quser.exe) -replace '\s{2,}',',' | ConvertFrom-Csv

# Linux: Wir benötigen alle Zeilen außer der ersten.
# Anschließend ersetzen wir alle aufeinanderfolgenden 
# Whitespaces durch ein Komma.

## Seite 130
$n = netstat -r
($n | Select-Object -Skip 1) -replace '\s{1,}',',' | ConvertFrom-Csv

whoami.exe /groups /fo csv | ConvertFrom-Csv

'Nürnberg'.replace('ü','ue')
'Nürnberg' -replace 'ü','ue'

'München,Nürnberg'.split(',')
'München,Nürnberg' -split ','

## Seite 131
# [System.Net.IPAddress]
'192.168.0.1' -as [IPAddress]
'::1' -as [IPAddress] -as [bool]

# [System.Net.Mail.MailAddress]
'charles.babbage@contoso.com' -as [mailaddress]

$unixdevs = 'Dennis Ritchie', 'Ken Thompson','Brian Kerningham'
$unixdevs | Convert-String -Example 'Dennis Ritchie=RitchieD'

## Seite 132
$unixdevs = @(
    'Dennis Ritchie; 1941 (New York)'
    'Ken Thompson; 1943 (New Orleans)'
    'Brian Kerningham; 1942 (Toronto)'
)
$unixdevs | Convert-String -Example 'Dennis Ritchie; 1941 (New York)=RitchieD, New York, 1941'

Get-Content -Path 'data.txt' | 
  ConvertFrom-String -TemplateFile 'template.txt' | 
    Sort-Object -Property yearofbirth | 
      Select-Object -Property yearofbirth,name, placeofbirth

################################################################
## Kapitel 14: (W)MI
################################################################

## Seite 136
<#  Siehe Datei "wmi1.vbs"

    ' WMI-Abfrage in Visual Basic Script (VBScript)
    set objWMI = GetObject("winmgmts:\\localhost\root\cimv2")
    set disks = objWMI.ExecQuery("Select * from WIN32_LogicalDisk Where DriveType = 3")
    for each disk in disks
      Ausgabe = disk.DeviceID& " " &disk.FreeSpace& " Kapazität"
      wscript.echo Ausgabe
    Next
 
#>

## Seite 137
<# Siehe Datei "wmi1.cmd"
 
:: WMI-Abfrage in der Eingabeauffordung
wmic.exe /node:sv1,sv2 path Win32_Logicaldisk where "drivetype=3" get DeviceID, Freespace
wmic.exe /node:sv1,sv2 Logicaldisk where "drivetype = 3" get DeviceID, Freespace

#>

# WMI-Abfrage in der Windows PowerShell
Get-WmiObject -ComputerName sv1,sv2  -Class WIN32_LogicalDisk |
  Where-Object -FilterScript {$_.DriveType -eq 3} |
    Select-Object -Property DeviceID, Freespace

## Seite 138
# WMI-Abfrage mittels WQL
Get-WmiObject -ComputerName sv1,sv2 -Query 'Select * from WIN32_LogicalDisk Where DriveType = 3'

# Vereinfachte Notation mit "-Filter"
Get-WmiObject -ComputerName sv1,sv2 -Class WIN32_LogicalDisk -Filter 'DriveType = 3'

## Seite 139
# Eine WMI-Methode nutzen
$process = Get-WmiObject -Class WIN32_Process -filter 'Name = "powershell.exe"'
$process.Terminate()

# Methodenaufruf mit Invoke-WMIMethod
$powershell = Get-WmiObject -Class WIN32_Process -filter 'Name = "powershell.exe"'
Invoke-WmiMethod -Path $powershell.__relpath -Name Terminate

# Statische Methoden nutzen
Invoke-WmiMethod -Path Win32_Process -Name create -ArgumentList 'powershell.exe'

## Seite 140
# WMI type accelerators
[wmi]'Win32_LogicalDisk.DeviceID="C:"'
[wmi]'\\sv1\root\cimv2:Win32_LogicalDisk.DeviceID="C:"'
([Wmiclass]'Win32_Process').create('powershell.exe')
([WMISEARCHER]'Select * from WIN32_LogicalDisk Where DriveType = 3').Get()

## Seite 141
# WMI-Abfragen mit den CIM-Cmdlets
Get-CimInstance -ComputerName sv1,sv2 -ClassName WIN32_LogicalDisk |
  Where-Object -FilterScript {$_.DriveType -eq 3}

Get-CimInstance -ComputerName sv1,sv2 -Query 'Select * from WIN32_LogicalDisk Where DriveType = 3'

Get-CimInstance -ComputerName sv1,sv2 -ClassName WIN32_LogicalDisk -Filter 'DriveType = 3'

# Methodenaufruf mit Invoke-CimMethod
Get-CimInstance -ClassName WIN32_Process -filter 'Name = "powershell.exe"' |
Invoke-CimMethod -MethodName Terminate 
Invoke-CimMethod -Query 'Select * from Win32_Process where Name="powershell.exe"' -MethodName 'Terminate'

# Aufruf einer statischen Methode mit Invoke-CimMethod
Get-CimClass -ClassName Win32_Process | Select-Object -ExpandProperty CimClassMethods
Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{CommandLine='powershell.exe'}

## Seite 142
# CimSession
$cimsession = New-CimSession -ComputerName sv1 -SkipTestConnection -Credential (Get-Credential)
Get-CimInstance -CimSession $cimsession -Class WIN32_LogicalDisk -Filter 'DriveType = 3'

# CimSession mit erweiterten Optionen
$cimsessionoption = New-CimSessionOption -Protocol Dcom
$cimsession = New-CimSession -ComputerName sv1 -SkipTestConnection -Credential (Get-Credential) -SessionOption $cimsessionOption
Get-CimInstance -CimSession $cimsession -Class WIN32_LogicalDisk -Filter 'DriveType = 3'

## Seite 143
# CDXML-Cmdlets und die korrespondierenden WMI-Klassen
Get-CimInstance -Namespace 'root/StandardCimv2' -ClassName 'MSFT_NetAdapter'
Get-NetAdapter

Get-CimInstance -Namespace 'root/StandardCimv2' -ClassName 'MSFT_NetAdapterHardwareInfoSettingData'
Get-NetAdapterHardwareInfo

Get-CimInstance -Namespace 'root/StandardCimv2' -ClassName 'MSFT_NetAdapterBindingSettingData'
Get-NetAdapterBinding

Get-CimInstance -Namespace 'root/StandardCimv2' -ClassName 'MSFT_NetAdapterStatisticsSettingData'
Get-NetAdapterStatistics

Get-CimInstance -Namespace 'root/StandardCimv2' -ClassName 'MSFT_NetIPAddress'
Get-NetIPAddress
 
Get-CimInstance -Namespace 'root/StandardCimv2' -ClassName 'MSFT_NetIPInterface'
Get-NetIPInterface

################################################################
## Kapitel 15: Entfernte Rechner verwalten
################################################################

## Seite 145
Get-Command | Where-Object -FilterScript {
  $_.parameters.keys -contains 'ComputerName'
}

## Seite 147
# Anpassen des Netzwerkprofils
Set-NetConnectionProfile -InterfaceAlias Ethernet -NetworkCategory Private

# PSRemoting erlauben
Enable-PSRemoting -Force # -SkipNetworkProfileCheck

Get-Service -Name WinRM | Select-Object -Property Name, Status, Starttype

Get-WSManInstance -ResourceURI 'winrm/config/listener' -Enumerate

## Seite 148
Get-PSSessionConfiguration

Get-NetFirewallRule -Name WinRM* |
Select-Object -Property Name, Displaygroup,
  Enabled, Profile, Description

Test-WSMan -ComputerName sv1 -Authentication Negotiate
Test-NetConnection -ComputerName sv1 -CommonTCPPort WINRM
New-PSSession -Computername sv1

## Seite 149
Get-Item -Path 'WSMan:\localhost\Client\TrustedHosts'
Set-Item -Path 'WSMan:\localhost\Client\TrustedHosts' -Value '*.oreilly.de' -Force

Enter-PSSession -ComputerName sv1 -Credential (Get-Credential)

$cred = Get-Credential
Invoke-Command -ComputerName sv1,sv2 -Credential $cred -ScriptBlock {
Restart-Service netlogon
}

$pssession = New-PSSession -ComputerName sv1,sv2 -Credential $cred
Invoke-Command -Session $pssession -ScriptBlock {
  New-SmbShare -Name 'Data' -Path 'c:\Data' -EncryptData $true
}

## Seite 150
$proxyCmdlets = Import-PSSession -Session $pssession -Module DNSServer -Prefix Remote
Get-RemoteDnsServerDiagnostics
Remove-Module -name $proxyCmdlets

Export-PSSession -OutputModule ProxyDNS -Session $pssession -Module DNSServer

# Eine lokale Variable remote nutzen
$service = 'netlogon'
Invoke-Command -Session $pssession -ScriptBlock {
  Get-Service -name $using:service
}

## Seite 151
function mytop {
  param (
      [int] $Count = 10
  )
  Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First $Count
}

Invoke-Command -Session $pssession -ScriptBlock ${function:mytop} -argumentlist 4

## Beispiel 1: System.Service.ServiceController
Invoke-Command -Computername sv1 -ScriptBlock {
  $service = Get-Service -Name w32time
  # System.Service.ServiceController
  Get-Member -InputObject $service
  # Methoden stehen zur Verfügung
  $service.start()
}

## Beispiel 2: Deserialized.System.ServiceProcess.ServiceController
$service = Invoke-Command -Computername sv1 -ScriptBlock {
  Get-Service -Name w32time
}

# Deserialized.System.ServiceProcess.ServiceController
Get-Member -InputObject $service

# Methoden stehen nicht zur Verfügung
$service.start() # Erzeugt eine Fehlermeldung!

## Seite 153
<#  Linux shell code
  service sshd restart
  chsh --shell /usr/bin/pwsh
#>

################################################################
## Kapitel 16: Hintergrundaufträge: Jobs
################################################################

## Seite 156
# Einen neuen Hintergrundauftrag starten
Start-Job -ScriptBlock {
  Get-FileHash -Path 'PowerShell-7-win-x64.msi'
}

# Statusinformationen erhalten
Get-Job

# Ergebnisse des Auftrags sichtbar machen
Receive-Job

$job1 = Start-Job -ScriptBlock {..}
$job2 = Start-Job -ScriptBlock {..}
Get-Job | Wait-Job | Receive-Job -keep

# Jobergebnisse gezielt abrufen
Receive-Job -job $job1 # -keep

# Jobliste löschen
Get-Job | Delete-Job

Get-FileHash -Path 'PowerShell-7-win-x64.msi' &

################################################################
## Kapitel 17: Überblick über die Integration in Produkte
################################################################

## Seite 158
# Eine neue Organisationseinheit anlegen
New-ADOrganizationalUnit -Name 'Forschung'

# Einen neuen Benutzer anlegen
New-ADUser -Name 'Ada Lovelace' -SamAccountName 'LovelaceA' -AccountPassword (Read-Host -AsSecureString) -Enabled $true -Path 'ou=Forschung,DC=oreilly,DC=de'

# Eine neue Gruppe anlegen
New-ADGroup -Name 'Informatiker' -SamAccountName 'Informatiker' -GroupCategory 'Security' -GroupScope 'Global' -Description 'Berühmte Informatiker' -Path 'ou=Forschung,DC=oreilly,DC=de'

# Hinzufügen von Benutzern zu Gruppen
Add-ADGroupMember -Identity 'Informatiker' -Members 'LovelaceA'

# Splatting der Parameter am Beispiel New-ADUser
$parameters = @{
    Name            = 'Ada Lovelace'
    SamAccountName  = 'LovelaceA'
    AccountPassword = Read-Host -AsSecureString
    Enabled         = $true
    Path            = 'ou=Forschung,DC=oreilly,DC=de'
    GivenName       = 'Ada'
## Seite 158
    Surname         = 'Lovelace'
    DisplayName     = 'Ada Lovelace'
    Description     = 'Testkonto'
    Title           = 'Countess of Lovelace'
    Company         = 'Oreilly'
    City            = 'London'
    Country         = 'GB'
    OtherAttributes = @{'carLicense' = 'LA42 ADA' }
}

New-ADUser @parameters

# Clientseitiges Filtern liefert nicht alle Benutzerdaten zurück.
Get-ADUser -Identity 'LovelaceA' | Select-Object -Property *
# Serverseitiges Filtern ist hingegen erfolgreich.
Get-ADUser -Identity 'LovelaceA' -Properties *

# Seite 160
# Suche nach mehreren AD-Objekten
Get-ADUser -Filter { title -like 'Countess*' }
Get-ADUser -LDAPFilter '(&(objectCategory=user)(objectClass=user)(title=Countess*))'
Get-ADGroup -Filter { description -like 'Berühmte*' }

## Seite 161
# Erzeugen einer Gruppe mittels Splatting
$parameters = @{
    Name           = 'Wissenschaftler'
    SamAccountName = 'Wissenschaftler'
    GroupCategory  = 'Security'
    GroupScope     = 'Global'
    Path           = 'ou=Forschung,DC=oreilly,DC=de'
    Description    = 'Berühmte Wissenschaftler'
}
New-ADGroup @parameters

# "Nested group membership"
Add-ADGroupMember -Identity 'Wissenschaftler' -Members 'Informatiker'

# Ada Lovelace => Informatiker => Wissenschaftler
Get-ADPrincipalGroupMembership -Identity 'LovelaceA' | Select-Object -Property Name
Get-ADGroupMember -Identity 'Wissenschaftler' -Recursive | Select-Object -Property Name

## Seite 162
# Starten der "Exchange Management Shell" in einer
# beliebigen PowerShell-Sitzung
. 'C:\Program Files\Microsoft\Exchange Server\V15\bin\RemoteExchange.ps1'
Connect-ExchangeServer -auto -ClientApplication:ManagementShell

# Exchange-Cmdlets finden
Get-Command -Module ex1.oreilly.de
Get-ExCommand | Where-Object -filterscript {
    $_.ModuleName -eq 'ex1.oreilly.de'
}

## Seite 163
# Einen neuen Benutzer/eine Mailbox anlegen
$parameters = @{
    Name               = 'Charles Babbage'
    UserPrincipalName  = 'charles.babbage@contoso.com'
    SamAccountName     = 'BabbageC'
    Password           = Read-Host -AsSecureString
    OrganizationalUnit = 'OU=Forschung,DC=contoso,DC=com'
    FirstName          = 'Charles'
    LastName           = 'Babbage'
    DisplayName        = 'Babbage, Charles'
}
New-Mailbox @parameters

# Mailboxen abfragen: -identity unterstützt auch Jokerzeichen
Get-Mailbox -identity 'Charles*'

# "Implicit Remoting" Microsoft Exchange
$pssession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri 'http://ex1.oreilly.de/PowerShell/' -Credential (Get-Credential) -Authentication Kerberos

## Seite 164
Import-PSSession $psSession
# Optional: Export des Moduls
Export-PSSession -Session $pssession -OutputModule 'ex1.oreilly.de'

Import-PSSession $psSession

# Optional: Export des Moduls
Export-PSSession -Session $pssession -OutputModule 'ex1.oreilly.de'

# Installation der Vorvoraussetzungen
Enable-WindowsOptionalFeature -Online -FeatureName IIS-LegacySnapIn, IIS-Metabase, IIS-IIS6ManagementCompatibility -all

# Download/Install Microsoft Visual C++ 2012 Redistributable Package
## Seite 165
$uri = 'http://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe'
Invoke-RestMethod -Uri $uri -OutFile $uri.Split('/')[-1]

Start-Process -FilePath $uri.split('/')[-1] -Wait -ArgumentList '/passive /norestart'

# Installation der "Management Tools" vom Exchange-Datenträger
.\Setup.exe /IAcceptExchangeServerLicenseTerms /Role:ManagementTools

## Seite 166
# Installation der ersten Generation
Find-Module -name MSOnline | Install-Module -Scope AllUsers

# Nur für Powershell 7
Import-Module -Name MSOnline -UseWindowsPowerShell

# Passwort/Benutzername
$cred = Get-Credential
Connect-MsolService -Credential $cred

# Basisinformationen ermitteln
Get-MsolCompanyInformation
Get-MsolDomain

## Seite 167
# Einen neuen Benutzer anlegen
$parameters = @{
    UserPrincipalName     = 'fran.allen@oreilly.de'
    DisplayName           = 'Fran Allen'
    FirstName             = 'Frances Elizabeth '
    LastName              = 'Allen'
    Password              = 'Pa$$w0rd'
    UsageLocation         = 'DE'
    LicenseAssignment     = 'oreilly:ENTERPRISEPACK'
    PreferredDataLocation = 'EUR'
}
New-MsolUser @parameters

# Benutzerdaten abrufen und modifizieren
$MsolUsers = Get-MsolUser
$MsolUsers | Format-Table -Property UserPrincipalName,
DisplayName, isLicensed, PasswordNeverExpires -AutoSize
$MsolUsers | Where-Object -filterscript {
    $_.PasswordNeverExpires -eq $false
} | Set-MsolUser -PasswordNeverExpires $true

## Seite 168
# AzureAD-Modul bereitstellen
Find-Module -Name AzureAD | Install-Module -Scope CurrentUser -Force
Get-Command -Module AzureAD

# AzureAD in PowerShell 7 laden
Import-Module -Name AzureAD -UseWindowsPowerShell

# Verbinden
$context = Connect-AzureAD

# Anzeigen einiger wichtiger Details
$context.Tenant.Id
Get-AzureADTenantDetail
Get-AzureADDomain

# Das PasswordProfile-Objekt erzeugen
$passwordprofile = [Microsoft.Open.AzureAD.Model.PasswordProfile]::new()

# Hier übergeben Sie einen einfachen String
$passwordprofile.Password = Read-Host

## Seite 169
# Den AzureAD-Benutzer anlegen
$parameters = @{
    DisplayName       = 'Zuse, Konrad'
    UserPrincipalName = 'konrad.zuse@oreilly.de'
    MailNickName      = 'konrad.zuse'
    PasswordProfile   = $passwordprofile
    AccountEnabled    = $true
    GivenName         = 'Konrad'
    Surname           = 'Zuse'
}

New-AzureADUser @parameters

# Eine AzureAD-Gruppe erstellen
New-AzureADGroup -DisplayName 'Informatiker' -MailEnabled $false -SecurityEnabled $true -MailNickName 'Informatiker'

# Für die weitere Verwendung benötigen wir die Object-ID.
$group = Get-AzureADGroup -SearchString 'Informatiker'
$group.objectid
 
# Hinzufügen von Merkmalen
Get-AzureADUser -SearchString 'zuse' | Set-AzureADUser -City 'Berlin'

# Benutzer zu Gruppen hinzufügen
foreach ($user in Get-AzureADUser -SearchString 'Berlin') {
    $user.objectid
    $user.DisplayName
    Add-AzureADGroupMember -objectid $group.ObjectId -RefObjectId $user.objectid
}

# Mitglieder einer Gruppe anzeigen lassen
Get-AzureADGroupMember -ObjectId $group.objectid

## Seite 170
# Installation der Az-Module
Find-Module -Name Az | Install-Module -Scope AllUsers
Get-Module -Name Az* -ListAvailable

# Optional: Laden aller Az-Module
Import-Module -Name Az

## Seite 171
# Azure-Log-in
Connect-AzAccount -UseDeviceAuthentication
Get-AzContext

# Azure-Log-out
Disconnect-AzAccount

# Überblick über bereits verwendete Ressourcen
Get-AzSubscription
Get-AzResourceGroup
Get-AzStorageAccount
Get-AzLocation | Select-Object -Property Location

# Ihre Konfiguration, passen Sie die Werte an
$rg = 'DemoRG'
$location = 'westeurope'

## Seite 172
$accountName = 'oreilly'
$sku = 'Standard_LRS' # Standard Locally Redundant Storage

# ResourceGroup und StorageAccount erstellen
New-AzResourceGroup -Name $rg -Location $location
New-AzStorageAccount -Name $accountName -ResourceGroupName $rg -Location $location -SkuName $sku

# Konfiguration prüfen
Get-AzStorageAccount -ResourceGroupName $rg

# Den Zugriffsschlüssel ermitteln
$storageskeys = Get-AzStorageAccountKey -ResourceGroupName $rg -AccountName $accountName

# Den Storage-Kontext definieren
$storageContext = New-AzStorageContext -StorageAccountName $accountName -StorageAccountKey $storageskeys[0].Value

# Die Freigabe erstellen
$share = New-AzStorageShare -Name 'kurzundgut' -Context $storageContext

# Die Konfiguration überprüfen (entspricht $share)
Get-AzStorageShare -Context $storageContext

## Seite 174
# Erreichbarkeit testen
Resolve-DnsName -Name $share.ShareClient.Uri.Host 
Test-NetConnection -Port 445 -ComputerName $share.ShareClient.Uri.Host

# Variablen für den Zugriff erstellen
$password = ConvertTo-SecureString -String $storageskeys[0].Value -AsPlainText -Force
$cred = [System.Management.Automation.PSCredential]::new("AZURE\$accountName", $password)
$smbUri = '\\' + $share.ShareClient.Uri.Host + '\' + $share.Name

# Laufwerk verbinden
New-PSDrive -Name 'O' -PSProvider FileSystem -Root $smbUri -Credential $cred -Persist

cmd.exe /C "cmdkey.exe /add:`"$($share.ShareClient.Uri.Host)`" /user:`"Azure\$accountname`" /pass:`"$($storageskeys[0].Value)`"" 
New-PSDrive -Name 'O' -PSProvider FileSystem -Root $smbUri -Persist

$vmParams = @{
    ResourceGroupName   = $rg
    Name                = 'DemoVM'
## Seite 175
    Location            = $location
    ImageName           = 'Win2019Datacenter'
    PublicIpAddressName = 'DemoPublicIp'
    Credential          = $cred
    OpenPorts           = 3389
}

$newVM1 = New-AzVM @vmParams    

# Überblick über die neue VM verschaffen
$newVM1.OSProfile
$newVM1 | Get-AzNetworkInterface | Select-Object -ExpandProperty IpConfigurations | Select-Object Name, PrivateIpAddress
$publicIp = Get-AzPublicIpAddress -Name DemoPublicIp -ResourceGroupName $rg
$publicIp | Select-Object Name, IpAddress, @{label = 'FQDN'; expression = { $_.DnsSettings.Fqdn } }

# Zugriff mittels RDP
Get-AzRemoteDesktopFile -ResourceGroupName $rg -Name 'DemoVM' -LocalPath 'DemoVM.rdp'

# Alternativ
mstsc.exe /v $publicIp.IpAddress

## Seite 176

# Löschen der VM
$newVM1 | Remove-AzVM -Force

# Löschen der vollständigen Ressourcengruppe
Remove-AzResourceGroup -Name $rg -Force -AsJob

################################################################
## Kapitel 18: Webservices nutzen
################################################################

## Seite 177
Invoke-WebRequest -Uri 'http://ipinfo.io/json'
Invoke-WebRequest -Uri 'http://worldtimeapi.org/api/ip'

## Seite 174
# A: Die eigene (öffentliche) IP ermitteln
$ipinfo = Invoke-WebRequest -Uri 'http://ipinfo.io/json'
$ipinfo.Content | ConvertFrom-Json

# B: In welcher Zeitzone befinden Sie sich?
$tzinfo = Invoke-WebRequest -Uri 'http://worldtimeapi.org/api/ip'
$tzinfo.Content | ConvertFrom-Json

# Wechselkurse der EZB ermitteln
[xml] $data = Invoke-WebRequest -Uri 'https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml'
$data.Envelope.Cube.Cube.Cube

Invoke-RestMethod -Uri 'http://ipinfo.io/json'
Invoke-RestMethod -Uri 'http://worldtimeapi.org/api/ip'

## Seite 179

# Header
Invoke-RestMethod -Headers @{'Accept' = 'application/json' } -Uri 'https://api.tronalddump.io/random/quote'

# Benutzername/Passwort Ã¼bergeben
$cred = Get-Credential
Invoke-RestMethod -Uri 'https://ipinfo.io/json' -Authentication Basic -Credential $cred

## Seite 179/180
# Berühmte Informatiker suchen
$sparql = 
@'
SELECT ?computer_scientistLabel ?date_of_birth WHERE {
    SERVICE wikibase:label {
    bd:serviceParam wikibase:language "[AUTO_LANGUAGE],en".
}
?computer_scientist wdt:P106 wd:Q82594.
OPTIONAL {
    ?computer_scientist wdt:P569 ?date_of_birth. }
}
LIMIT 100
'@
Invoke-RestMethod -Headers @{'Accept' = 'text/csv' } -Uri "https://query.wikidata.org/sparql?query=$sparql" | ConvertFrom-Csv

################################################################
## Kapitel 19: Die Evolution der PowerShell
################################################################

## Seite 181
Get-WmiObject -Class Win32_LogicalDisk -ComputerName sv1

## Seite 182
# Beispiel 1: klassische Schreibweise (Array-Syntax)
Get-Process | Where-Object -FilterScript { $_.Handles -gt 500 }

# Beispiel 2: vereinfachte Schreibweise (Simplified Syntax)
Get-Process | Where Handles -gt 500

## Seite 185
Enter-PSSession -hostname 'linux-sv1'
Invoke-Command -HostName 'linux-sv1' -ScriptBlock { uptime }

################################################################
## Kapitel 20: Neuerungen in PowerShell 7
################################################################
## Seite 187
1..5 | ForEach-Object -Parallel { Start-Sleep -Seconds 1 }

Start-ThreadJob -ScriptBlock { Start-Sleep -Seconds 1 }
Get-Job | Wait-Job

## Seite 188
$files = Get-ChildItem -Path C:\Windows -Recurse
-force -ErrorAction SilentlyContinue

# Gruppieren
Measure-Command -Expression {
    $files | Group-Object -Property Extension | Sort-Object -Property Count -Descending
} | Select-Object -Property TotalSeconds

# Sortieren
Measure-Command -Expression {
    $files | Sort-Object -Property Length | Select-Object -Property Length, Fullname
} | Select-Object -Property TotalSeconds

# Formatierte Ausgabe
Measure-Command -Expression {
    $files | Format-Table -Property Length, Fullname
} | Select-Object -Property TotalSeconds

Measure-Command -Expression {
    $files | Format-List -Property Length, Fullname
} | Select-Object -Property TotalSeconds

## Seite 189
# Detailanzeige zu aufgetretenen Fehlern
Get-Error # Zeigt nur den letzten Fehler
Get-Error -Newest 5

# Auswahl des Anzeigemodus: NormalView, CategoryView, ConciseView
$errorview = 'NormalView'

## Seite 191

# Ternary Operator, allgemeine Syntax:
$a -eq $b ? $true : $false

## Seite 187
# Ein Beispiel
(Test-Connection -TargetName 'www.oreilly.de' -TcpPort 80) ? 'Erfolg' : 'Misserfolg'

# Das Gleiche mit if-else
if (Test-Connection -TargetName 'www.oreilly.de' -TcpPort 80) {'Erfolg'} else {'Misserfolg'}

# Pipeline Chain Operators, allgemeine Syntax
($a -eq $b) ?? $true || $false

# Ein Beispiel
Test-Connection -TargetName 'www.oreilly.de' -TcpPort 80 && 'Erfolg' || 'Misserfolg'

# Ein Beispiel, das in PowerShell und cmd.exe funktioniert
ping localhost && echo "Erfolg" || echo "Misserfolg"

## Seite 192
ping 42:: && echo "Erfolg" || echo "Misserfolg"

# Fehlerhafter Versuch
if (ping 42::) {'Erfolg'} else {'Misserfolg'}

# Mit erhöhtem Aufwand zum Erfolg
ping 42::
if ($LASTEXITCODE -eq 0) {'Erfolg'} else {'Misserfolg'}

(Get-ChildItem -Filter '*.docx') ?? 'Keine Dokumente gefunden!'

## Seite 193
# Beispiel 1
$name = 'Thorsten'
$name ??= 'Max'
$name # Die Ausgabe wird "Thorsten" lauten.

# Beispiel 2
$name = $null
$name ??= 'Max'
$name # Die Ausgabe wird "Max" lauten.

# Das experimentelle Feature aktivieren
Get-ExperimentalFeature
Enable-ExperimentalFeature -Name 'PSNullConditionalOperators'

# Beispiel 1: der klassische Weg
$enten = 'Tick','Trick','Track'
try {
    $enten[0]
}
catch {
    $Error[0]
}

## Seite 194
# Beispiel 2: Null-conditional Member Access Operator
$enten = 'Tick','Trick','Track'
${enten}?[0]

# Beispiel 3: Eine nicht initialisierte Variable
$enten = $null
${enten}?[0]

# Beispiel 4: Der übliche Weg
$service = Get-Service -Name 'bits'
$service.Status
$service.Start()
$service.Stop()

# Beispiel 5: Der Dienst ist unbekannt
$service = Get-Service -Name 'nothing'
${Service}?.Status
${Service}?.Start()
${Service}?.Stop()

## Seite 195

# Ermitteln der PS7-spezifischen Module
$modules = Get-Module -ListAvailable | Where-Object -FilterScript { $_.path -like "$pshome*" }

# Ermitteln der zugehörigen Cmdlets
Get-Command | Where-Object -FilterScript { $_.Source -in $modules.name } | Sort-Object -Property Name | Get-Unique | Measure-Object

## Seite 196
# Suchpfade der PowerShell
$env:PSModulePath.split(';')

# Ein einfacher Test mit dem WindowsSearch-Modul
Get-WindowsSearchSetting

## Seite 197
# Installation der RSAT in Windows 10
Get-WindowsCapability -Online -Name 'rsat.dhcp*' | Add-WindowsCapability -Online

## Seite 198
Import-Module -Name DHCPServer -UseWindowsPowerShell

## Seite 199
$cred = Get-Credential
$PSSession = New-PSSession -ComputerName sea-dc1 -Credential $cred
$ProxyModule = Import-PSSession -Session $PSSession -Module DhcpServer
Get-DhcpServerInDC

################################################################
## Anhang: Windows PowerShell Desired State Configuration (DSC) 
################################################################

## Seite 202
# Den Sollzustand definieren
Configuration DNSHost {
  node ('sv1') {
      WindowsFeature DNS {
          Ensure = 'Present'
          Name   = 'DNS'
      }
      WindowsFeature RSAT-DNS-Server {
          Ensure    = 'Present'
          Name      = 'RSAT-DNS-Server'
          DependsOn = '[WindowsFeature]DNS'
      }
  }
}
# Erzeugen der MOF-Datei
DNSHost

# Liste alle vorhandenen DSC-Ressourcen auf
Get-DscResource

# In Windows Server integriert: "WindowsFeature"
Get-DscResource -Name WindowsFeature

## Seite 203
Start-DscConfiguration -Path .\DNSHost -Wait -Verbose

Get-DscConfiguration

Remove-DscConfigurationDocument -Stage Current

## Seite 204
Find-Module -tag DSC -Repository PSGallery
Find-DscResource -Repository PSGallery
Install-Module -Name xActiveDirectory -Repository PSGallery