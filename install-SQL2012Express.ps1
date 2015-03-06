$fromfile1 = "http://download.microsoft.com/download/8/D/D/8DD7BDBA-CEF7-4D8E-8C16-D9F69527F909/ENU/x64/SQLEXPRWT_x64_ENU.exe"
$tofile1   = "C:\tmp\SQLEXPRWT_x64_ENU.exe"
$sqlcmd = "C:\tmp\SQL\setup.exe"
$taskimport = "C:\vagrant\installSQL2012.xml"
$taskname = "installSQL2012"
$hostname = $env:computername
$installerProcessname="ScenarioEngine"
$vagrantinstall=1

If (Test-Path $tofile1){
  # // File exists
}Else{
Write-Host -Object "downloading $fromfile1";
$webclient = New-Object System.Net.WebClient
$webclient.DownloadFile($fromfile1, $tofile1)
}

If (Test-Path $sqlcmd){
  # // File exists
}Else{

Write-Host -Object "Extracting files $tofile1 SQL 2012 with Management studio";
& 'C:\tmp\SQLEXPRWT_x64_ENU.exe' /quiet /extract:"C:\tmp\SQL"
Start-Sleep -s 90
}
If (Test-Path $sqlcmd){
    Write-Host -Object "file $sqlcmd now exists";
    Write-Host -Object "Setting up task to run install $taskcmd";
    If ($vagrantinstall -eq 1)
        {
         Write-Host -Object "runng vagrant based install";
        schtasks.exe /create /S $hostname /RU vagrant /RP vagrant /TN $taskname /XML $taskimport
        $timestring1= get-date -format "HH"
        $timestring2= get-date -format "mm"
        $datetring= get-date -format "MM/dd/yyyy"
        $intNum2=2+$timestring2
        $starttime=$timestring1+":"+$intNum2
        #schtasks /Change /S $hostname /RU vagrant /RP vagrant /TN $taskname /ST $starttime /SD $datetring
        #Write-Host -Object "changing $taskname to run at $starttime and this date $datetring";
        schtasks /Run /TN $taskname
        }
    Else
        {
        $arguments = ' /q /ACTION=Install /FEATURES=SQL,Tools /TCPENABLED=1 /INSTANCENAME=SQLEXPRESS /SQLSVCACCOUNT="NT AUTHORITY\Network Service" /SQLSYSADMINACCOUNTS="vagrant" /AGTSVCACCOUNT="NT AUTHORITY\Network Service" /IAcceptSQLServerLicenseTerms'
        
        }
}Else{
    Write-Host -Object "file $sqlcmd still does not exists installation FAILDED!!!";
}

Start-Sleep -s 120
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



