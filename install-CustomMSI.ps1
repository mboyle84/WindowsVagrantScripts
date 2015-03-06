$fromfile1 = "http://website.net/file.zip"
$tofile1   = "C:\tmp\file.zip"
$zippath = "C:\tmp"
$zipname = "file.zip"
$logfile= "C:\tmp\Softwarelog.txt"
$unzippath = "C:\tmp\Software"
$installfile="C:\tmp\Software\zippedfolder\Setup.exe"

function unzip($fileName, $sourcePath, $destinationPath)
{
    $shell = new-object -com shell.application
    if (!(Test-Path "$sourcePath\$fileName"))
    {
        throw "$sourcePath\$fileName does not exist" 
    }
    New-Item -ItemType Directory -Force -Path $destinationPath -WarningAction SilentlyContinue
    $shell.namespace($destinationPath).copyhere($shell.namespace("$sourcePath\$fileName").items()) 
}
If (Test-Path $installfile){
  # // File exists
}Else{
    Write-Host -Object "downloading $fromfile1";
    $webclient = New-Object System.Net.WebClient
    $webclient.DownloadFile($fromfile1, $tofile1)
    Write-Host -Object "Extracting $fromfile1";
    unzip $zipname $zippath $unzippath
}

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
Write-Host -Object "attempt install of  $installfile";
& 'C:\Windows\System32\msiexec.exe' /qb /l* $logfile /i $installfile
Write-Host -Object "$installfile is being installed with default settings";