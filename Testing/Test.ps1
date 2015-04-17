$logfile="C:\tmp\SikuliCopy.txt"
$logfile2="C:\tmp\Testing\Test.sikuli\TestResults.txt"
$TestFolder="C:\tmp\Testing"
$Testing="C:\vagrant\Testing"
$Images="C:\vagrant\Images\"
$ImagesD="C:\tmp\Images\"
Write-Host -Object "Beginning Testing Setup";
echo D|xcopy $Testing $TestFolder /E >> $logfile
echo D|xcopy $Images $ImagesD /E >> $logfile
$SikuliScript="C:\Program Files (x86)\Sikuli X\sikuli-script.jar"
$SikuliScriptD="C:\tmp\Testing\sikuli-script.jar"
#$startesting1 = "& 'C:\Program Files (x86)\Java\jre7\bin\javaw.exe' -jar 'C:\tmp\Testing\sikuli-script.jar' C:\tmp\Testing\calc.sikuli"
$startesting2 = "& 'C:\Program Files (x86)\Java\jre7\bin\java.exe' -jar 'C:\tmp\Testing\sikuli-script.jar' C:\tmp\Testing\Test.sikuli >> $logfile2"
#$startestingcmd1="C:\tmp\Testing\testing.ps1"
$startestingcmd2="C:\tmp\Testing\testing2.ps1"
#$taskimport = "C:\tmp\Testing\Test.xml"
$taskimport2 = "C:\tmp\Testing\Test2.xml"
$hostname = $env:computername
#$taskname = "Test"
$taskname2 = "Test2"
Write-Host -Object "Copy appropriate files to testing folder";
echo f|xcopy $SikuliScript $SikuliScriptD /E >> $logfile
echo f|xcopy $SikuliScript $SikuliScriptD /E >> $logfile
& cd $TestFolder
Write-Host -Object "Extracting Silkuli script to testing Folder";
& 'C:\Program Files\Java\jdk1.7.0_60\bin\jar.exe' xf C:\tmp\Testing\sikuli-script.jar
#Write-Host -Object "creating testcmd for restart and auto login";
#$startesting1 | Out-File $startestingcmd1
$startesting2 | Out-File $startestingcmd2
#Write-Host -Object "Setting up Startup Task";
#schtasks.exe /create /IT /S $hostname /TN $taskname /XML $taskimport
schtasks.exe /create /IT /S $hostname /TN $taskname2  /XML $taskimport2
#schtasks /Run /TN $taskname2
#Write-Host -Object "running testing";
#& 'C:\Program Files (x86)\Java\jre7\bin\java.exe' -jar 'C:\tmp\Testing\sikuli-script.jar' C:\tmp\Testing\Test.sikuli
Write-Host -Object "Shuting down Machine so it can be start in full screen mode for testing";
Add-Content $startestingcmd2 "`n& '$env:SystemRoot\system32\slmgr.vbs' /upk >> $logfile2"
& shutdown -s -t 0
#Start-Sleep 15

