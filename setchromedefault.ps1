$chromePath = "${Env:ProgramFiles(x86)}\Google\Chrome\Application\" 
$chromeApp = "chrome.exe"
$chromeCommandArgs = "--make-default-browser"
$chromeCommandArgs2 = "--homepage http://google.com --silent-launch"
Write-Host "set chrome to default browser"	
& "$chromePath$chromeApp" $chromeCommandArgs
Write-Host "set chrome homepages"	
& "$chromePath$chromeApp" $chromeCommandArgs2
