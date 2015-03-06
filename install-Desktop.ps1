#remove unwanted icons
Write-Host -Object "removing all existing icons from desktop";
#Remove-Item C:\Users\vagrant\Desktop\*lnk -Force
#echo All
Remove-Item C:\Users\Public\Desktop\*lnk -Force
echo All
