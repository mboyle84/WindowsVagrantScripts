#license file locaiton in vagrant sync folder
$macdescription = Get-WmiObject win32_networkadapterconfiguration | select description, macaddress|where-object {$_.description -eq 'Intel(R) PRO/1000 MT Desktop Adapter'}

$TestingMac="08:00:27:89:C5:7A"
$User1Mac="08:00:27:89:C5:7B"
$User2Mac="08:00:27:89:C5:7C"
$User3Mac="08:00:27:89:C5:7D"
$User4Mac="08:00:27:89:C5:7E"
$User5Mac="08:00:27:89:C5:7F"
#remove : from file
$TestingMac2 = $TestingMac.replace(':','')
$User1Mac2 = $User1Mac.replace(':','') 
$User2Mac2 = $User2Mac.replace(':','') 
$User3Mac2 = $User3Mac.replace(':','') 
$User4Mac2 = $User4Mac.replace(':','') 
$User5Mac2 = $User5Mac.replace(':','') 


If ($macdescription -match $TestingMac ) 
    {
        $licensefileo= "C:\vagrant\Licensing\"+$TestingMac2+"\licensefile"
	    $licensefilec= "C:\vagrant\Licensing\"+$TestingMac2+"\licensefilecomputer"
	    Write-Host "Mac address is $TestingMac, moving appropriate licensig files $licensefileo and $licensefilec"
	    $activationcode="code"
    }
    Elseif ($macdescription -match $User1Mac )
    {
	    $licensefileo= "C:\vagrant\Licensing\"+$User1Mac2+"\licensefile"
	    $licensefilec= "C:\vagrant\Licensing\"+$User1Mac2+"\licensefilecomputer"
	    Write-Host "Mac address is $User1Mac, name appropriate licensig file paths to $licensefileo and $licensefilec"
	    
    }
    Elseif ($macdescription -match $User2Mac )
    {
	    $licensefileo= "C:\vagrant\Licensing\"+$User2Mac2+"\licensefile"
	    $licensefilec= "C:\vagrant\Licensing\"+$User2Mac2+"\licensefilecomputer"
    	Write-Host "Mac address is $User2Mac, name appropriate licensig file paths to $licensefileo and $licensefilec"	
    	
    }
    Elseif ($macdescription -match $User3Mac )
    {
	    $licensefileo= "C:\vagrant\Licensing\"+$User3Mac2+"\licensefile"
	    $licensefilec= "C:\vagrant\Licensing\"+$User3Mac2+"\licensefilecomputer"
    	Write-Host "Mac address is $User3Mac, name appropriate licensig file paths to $licensefileo and $licensefilec"	
    	
    }
    Elseif ($macdescription -match $User4Mac )
    {
    	$licensefileo= "C:\vagrant\Licensing\"+$User4Mac2+"\licensefile"
	    $licensefilec= "C:\vagrant\Licensing\"+$User4Mac2+"\licensefilecomputer"
	    Write-Host "Mac address is $User4Mac, name appropriate licensig file paths to $licensefileo and $licensefilec"
	   
    }
    Elseif ($macdescription -match $User5Mac )
    {
	    $licensefileo= "C:\vagrant\Licensing\"+$User5Mac2+"\licensefile"
	    $licensefilec= "C:\vagrant\Licensing\"+$User5Mac2+"\licensefilecomputer"
    	Write-Host "Mac address is $User5Mac, name appropriate licensig file paths to $licensefileo and $licensefilec"
    	
    }
    Else
    {
        Write-Host "unreconize mac address $macdescription no licensing applied, licensing FAILED "
    }



#general app data license file 
$appdatalicense1="C:\Users\vagrant\AppData\Roaming\licensefile"
$appdatalicense2="C:\Users\vagrant\AppData\Roaming\licensefilecomputer"
$appdatalicense1="C:\Users\vagrant\AppData\local\licensefile"
$appdatalicense2="C:\Users\vagrant\AppData\local\licensefilecomputer"
Write-Host -Object "licensing $appdatalicense1 and $appdatalicense2 with license files $licensefileo and $licensefilec ";
echo f|xcopy $licensefileo $appdatalicense1 /E
echo f|xcopy $licensefilec $appdatalicense2 /E
echo f|xcopy $licensefileo $appdatalicense3 /E
echo f|xcopy $licensefilec $appdatalicense4 /E



#license custom software
$CustSoftwarelicensePath1 = "C:\Program Files (x86)\softwarefolder\licensefile"
$CustSoftwarelicensePath2 = "C:\Program Files (x86)\softwarefolder\licensefilecomputer"
$CustSoftwareExe="C:\Program Files (x86)\softwarefolder\executable.exe"
If (Test-Path $CustSoftwareExe){
    Write-Host -Object "licensing $CustSoftwareExe with license files $licensefileo and $licensefilec ";
    echo f|xcopy $licensefileo $CustSoftwarelicensePath1 /E
    echo f|xcopy $licensefilec $CustSoftwarelicensePath2 /E
}Else{
    Write-Host -Object "File does not exist not licensing software $CustSoftwareExe";
}   