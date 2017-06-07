Vagrant.configure("2") do |config|
  config.vm.box = "puppetlabs/ubuntu-16.04-64-puppet"
  config.vm.network "private_network", ip: "50.50.50.111"
  
  config.vm.provider "virtualbox" do |vb|
     vb.memory = "1024"
  end
  config.vm.provision "shell", path: "./install_stdlib.sh"

  config.vm.provision :puppet do |puppet|
     puppet.environment = "production"
     puppet.environment_path = "."
     puppet.manifests_path = "puppet/manifests"
     puppet.manifest_file = "site.pp"
     puppet.module_path = "puppet/modules"
  end
end
