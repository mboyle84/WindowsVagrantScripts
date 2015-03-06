winrm quickconfig -q
   winrm set winrm/config/winrs @{MaxMemoryPerShellMB="512"}
   winrm set winrm/config @{MaxTimeoutms="1800000"}
   winrm set winrm/config/service @{AllowUnencrypted="true"}
   winrm set winrm/config/service/auth @{Basic="true"}
   sc config WinRM start= auto
netsh firewall add portopening TCP 5985 "Port 5985"
winrm set winrm/config/listener?Address=*+Transport=HTTP @{Port="5985"}