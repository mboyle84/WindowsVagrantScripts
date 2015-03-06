
VAGRANTFILE_API_VERSION = "2"
# Require the reboot plugin.
require './vagrant-provision-reboot-plugin'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
 
config.vm.provider "virtualbox" do |vb|
  
        #vb.gui = true
        vb.customize ["modifyvm", :id, "--memory", "8192"]
        vb.cpus = 1
        #Change the mac from default to not interrupt communication on network.The mac might already exist, same thing for hostname below.
        #vb.customize ["modifyvm", :id, "--macaddress1", "08002789C57A" ]
        
        #mac changes per user for tradeshow
        #User1
            #vb.customize ["modifyvm", :id, "--macaddress1", "08002789C57B" ]
        #User2
            vb.customize ["modifyvm", :id, "--macaddress1", "08002789C57C" ]
        #User3
            #vb.customize ["modifyvm", :id, "--macaddress1", "08002789C57D" ]
        #User4
            #vb.customize ["modifyvm", :id, "--macaddress1", "08002789C57E" ]
        #User5
            #vb.customize ["modifyvm", :id, "--macaddress1", "08002789C57F" ]
        
end

#defines Machine to use for Base
config.vm.box = "Win7x64_Net4" # the name of the box, completed for you by vagrant init
#config.vm.box = "Win81x64_Base" # the name of the box, completed for you by vagrant init

#general network and machine settings
config.vm.guest = :windows
#modify the host name and above mac from defaults.Otherwise, collitions could occur on the network
config.vm.hostname = "Win7x64SQLE2012"

#user based hostanmes, could us enviromental variable from pc, but this also works. 
    #User1
        #config.vm.hostname = "Win7x64TUser1"
    #User2
        #config.vm.hostname = "Win7x64TUser2"
    #User3
        #config.vm.hostname = "Win7x64TUser3"
    #User4
        #config.vm.hostname = "Win7x64TUser4"
    #User5
        #config.vm.hostname = "Win7x64TUser5"

config.vm.communicator = "winrm"
#restart due to hostname change above reboot pluing above actualyl works with this command
config.vm.provision :windows_reboot

# forward RDP and WINRS ports
config.vm.network :forwarded_port, guest: 3389, host: 3377, id: "rdp", auto_correct: false
config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
config.winrm.max_tries = 10
  
# Ensure that all networks are set to private
config.windows.set_work_network = true

# chocolatey:
config.vm.provision :shell, path: "install-chocolatey.ps1"
config.vm.provision :shell, inline: '[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Chocolatey\bin", "Machine")'
  # Puppet:
config.vm.provision :shell, path: "install-puppet.ps1"
config.vm.provision :shell, path: "install-puppet-modules.ps1"
config.vm.provision "puppet"
	config.vm.provision :puppet do |puppet|
#	puppet.manifests_path = "./manifests"
#	puppet.module_path = "modules"
#	puppet.manifest_file = "default.pp"
#	puppet.options = "--verbose --debug"

end

#I cannot get any of the SQL express to install via chocolaty, puppet. So, I used powershell, with schedule task. 
config.vm.provision :shell, path: "install-SQL2012Express.ps1"
#config.vm.provision :shell, path: "install-SQL2008Express.ps1"

#set chrome defaultbrowser
config.vm.provision :shell, path: "setchromedefault.ps1"

#inline command to add delay, this is just to show you can run powershell command directly if desired.
#config.vm.provision "shell", inline: "Start-Sleep -s 1800"

#custome msi package from any website zipped for example
#config.vm.provision :shell, path: "install-CustomMSI.ps1"

#license example based of mac, for example, no licensing folder include in example, you can make your own, just here as placeholder/example.
#config.vm.provision :shell, path: "install-CustomLicensing.ps1"

#clears Desktop icons from install, I find them annoying on based testing image. 
config.vm.provision :shell, path: "install-Desktop.ps1"


end
