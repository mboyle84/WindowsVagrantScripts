  
# install notepad++
#package { "notepadplusplus" :
#  ensure => "latest",
#  provider => 'chocolatey',
#}


package { "vcredist2010" :
  ensure => "latest",
  provider => 'chocolatey',
}

package { "reportviewer2010sp1" :
  ensure => "latest",
  provider => 'chocolatey',
}
    
package { "vcredist2012" :
  ensure => "latest",
  provider => 'chocolatey',
}

package { "google-chrome-x64" :
  ensure => "latest",
  provider => 'chocolatey',
}

package { "adobereader" :
  ensure => "latest",
  provider => 'chocolatey',
}


package { "powerpointviewer" :
  ensure => "latest",
  provider => 'chocolatey',
}

package { "sqliteexpert.install -Version 3.5.63" :
  ensure => "latest",
  provider => 'chocolatey',
}

package { "dotnet4.5" :
  ensure => "latest",
  provider => 'chocolatey',
}

package { "vlc" :
  ensure => "latest",
  provider => 'chocolatey',
}



