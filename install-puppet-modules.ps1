$pfx = new-object System.Security.Cryptography.X509Certificates.X509Certificate2 
$certPath =  "C:\vagrant\GeoTrust_Global_CA.pfx"
#$pfxPass = read-host "Password" -assecurestring
$pfx.import($certPath,$pfxPass,"Exportable,PersistKeySet") 
$store = new-object System.Security.Cryptography.X509Certificates.X509Store(
    [System.Security.Cryptography.X509Certificates.StoreName]::Root,
    "localmachine"
)
$store.open("MaxAllowed") 
$store.add($pfx) 
$store.close()
Write-Host "Certificate added from GeoTrust to Trust Root to allow puppet forge SSL certificate on clean machine"
& 'C:\Program Files\Puppet Labs\Puppet\bin\puppet.bat' module install rismoney-chocolatey
