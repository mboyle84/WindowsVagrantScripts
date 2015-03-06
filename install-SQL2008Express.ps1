$fromfile1 = "http://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLEXPRWT_x64_ENU.exe"
$tofile1   = "C:\tmp\SQLEXPRWT_x64_ENU.exe"
$sqlcmd = "C:\tmp\SQL\setup.exe"
$arguments = ' /q /ACTION=Install /FEATURES=SQLENGINE /INSTANCENAME=MSSQLSERVER /SQLSVCACCOUNT="NT AUTHORITY\SYSTEM" /SQLSYSADMINACCOUNTS="vagrant" /AGTSVCACCOUNT="NT AUTHORITY\Network Service" /IAcceptSQLServerLicenseTerms'
$taskimport = "C:\vagrant\installSQL2008.xml"
$taskname = "installSQL2008"
$hostname = $env:computername
$installerProcessname="setup100"


If (Test-Path $tofile1){
  # // File exists
}Else{
$webclient = New-Object System.Net.WebClient
Write-Host -Object "downloading $fromfile1";
$webclient.DownloadFile($fromfile1, $tofile1)
}

If (Test-Path $sqlcmd){
  # // File exists
}Else{
Write-Host -Object "Extracting $tofile1";
& 'C:\tmp\SQLEXPRWT_x64_ENU.exe' /quiet /extract:"C:\tmp\SQL"
Start-Sleep -s 90
}
If (Test-Path $sqlcmd){
Write-Host -Object "file $sqlcmd now exists";
Write-Host -Object "Setting up task to run install $taskcmd";
schtasks.exe /create /S $hostname /RU vagrant /RP vagrant /TN $taskname /XML $taskimport
$timestring1= get-date -format "HH"
$timestring2= get-date -format "mm"
$datetring= get-date -format "MM/dd/yyyy"
$intNum2=2+$timestring2
$starttime=$timestring1+":"+$intNum2
#schtasks /Change /S $hostname /RU vagrant /RP vagrant /TN $taskname /ST $starttime /SD $datetring
#Write-Host -Object "changing $taskname to run at $starttime and this date $datetring";
schtasks /Run /TN $taskname # 
}Else{
Write-Host -Object "file $sqlcmd still does not exists installation FAILDED!!!";
}

$i = 0
While ($i -le 0)
{
$processes=Get-WmiObject win32_process | Select-Object Name,@{n='Owner';e={$_.GetOwner().User}} | sort nam
        If ($processes -match $installerProcessname ) 
            {
                Write-Host -Object "SQL installing waiting 5 minutes";
                $i = 0
                Start-Sleep -s 300
            }
        else
            {
                Write-Host -Object "SQL install process finished";
                $i = 1
            }
}