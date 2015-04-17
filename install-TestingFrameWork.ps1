$fromfile1 = "http://search.maven.org/remotecontent?filepath=org/python/jython-installer/2.5.3/jython-installer-2.5.3.jar"
$fromfile2 = "https://bootstrap.pypa.io/get-pip.py"
$fromfile3 = "https://launchpad.net/sikuli/sikulix/x1.0-rc3/+download/Sikuli-X-1.0rc3%20%28r905%29-win32.exe"
$fromfile4= "http://the.earth.li/~sgtatham/putty/latest/x86/pscp.exe"
$tofile1   = "C:\tmp\jython-installer-2.5.3.jar"
$tofile2   = "C:\tmp\get-pip.py"
$tofile3   = "C:\tmp\Sikuli-X-1.0rc3 (r905)-win32.exe"
$tofile4   = "C:\tmp\pscp.exe"
Write-Host -Object "downloading $fromfile1";
$webclient = New-Object System.Net.WebClient
$webclient.DownloadFile($fromfile1, $tofile1)
$installfile="C:\tmp\jython-installer-2.5.3.jar"
$installfile2="C:\tmp\get-pip.py"
$installfile3="'C:\tools\python2\Scripts\pip.exe' install robotframework"
$installfile4="C:\tmp\Sikuli-X-1.0.3-win32.msi"
$logfile="C:\tmp\Sikulilog.txt"

Write-Host -Object "attempt install of  $installfile";
& 'C:\Program Files\Java\jre7\bin\java.exe' -jar $installfile -s -d 'C:\Program Files (x86)\jython'
Write-Host -Object "downloading $fromfile2";
$webclient.DownloadFile($fromfile2, $tofile2)
Write-Host -Object "attempt install of  $installfile2";
& python $installfile2
Write-Host -Object "attempt install of  $installfile3";
& 'C:\tools\python2\Scripts\pip.exe' install robotframework
Write-Host -Object "downloading $fromfile3";
$webclient.DownloadFile($fromfile3, $tofile3)
Write-Host -Object "Extracting $tofile3";
& 'C:\tmp\Sikuli-X-1.0rc3 (r905)-win32.exe' /quiet /extract


$msiexe = "C:\Windows\System32\msiexec.exe"
 $installerProcessname="msiexec"
    $username="vagrant"
    $i = 0
    While ($i -le 0)
    {
        $processes=Get-WmiObject win32_process | Select-Object Name,@{n='Owner';e={$_.GetOwner().User}} | sort nam
        If (($processes -match $installerProcessname ) -and ($processes -match $username)) 
            {
                Write-Host -Object " waiting 2 minutes for installs to finish";
                $i = 0
                Start-Sleep -s 120
            }
        else
            {
                Write-Host -Object "install process finished";
                $i = 1
            }
    }
Write-Host -Object "Attempting instal of $installfile4";
& 'C:\Windows\System32\msiexec.exe' /qb /l* $logfile /i $installfile4
Write-Host -Object "Auto login should be setup on base image if not, attempting to add it now";
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"  
Set-ItemProperty $RegPath "AutoAdminLogon" -Value "1" -type String  
Set-ItemProperty $RegPath "DefaultUsername" -Value "vagrant" -type String  
Set-ItemProperty $RegPath "DefaultPassword" -Value "vagrant" -type String
Write-Host -Object "Enabling logs for schedule tasks";
$logName = 'Microsoft-Windows-TaskScheduler/Operational'
$log = New-Object System.Diagnostics.Eventing.Reader.EventLogConfiguration $logName
$log.IsEnabled=$true
$log.SaveChanges()
Write-Host -Object "downloading $fromfile4";
$webclient.DownloadFile($fromfile4, $tofile4)
