$fromfile1 = "http://modusmed.com/images/downloads/QUASAR_eQA_Software.zip"
$tofile1   = "C:\tmp\QUASAR_eQA_Software.zip"
$zippath = "C:\tmp"
$zipname = "QUASAR_eQA_Software.zip"
$unzippath = "C:\tmp\eQA"
$logfile= "C:\tmp\WarehouseDatabaselog.txt"
$installfile="C:\tmp\eQA\eQA 2.1\Database\warehouse.2.1.0.setup.exe"
Write-Host -Object "Installing WarehouseDatabase";
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

If (Test-Path $installfile){
    Write-Host -Object "attempt install of  $installfile";
& $installfile /s /v/qn
    Start-Sleep -s 180
    Write-Host -Object "$installfile is being installed with default settings";
}Else{
    Write-Host -Object "$installfile missing installation FAILED";
}


$installerProcessname="msiexec"

$username="vagrant"

    
        


$i = 0
While ($i -le 0)
{
$processes=Get-WmiObject win32_process | Select-Object Name,@{n='Owner';e={$_.GetOwner().User}} | sort nam
        If (($processes -match $installerProcessname ) -and ($processes -match $username)) 
            {
                Write-Host -Object " waiting 2 minutes for install to finish";
                $i = 0
                Start-Sleep -s 120
            }
        else
            {
                Write-Host -Object "install process finished";
                $i = 1
            }
}
