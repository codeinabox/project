BOX_NAME = ENV['BOX_NAME'] || "precise64"
BOX_URI = ENV['BOX_URI'] || "http://files.vagrantup.com/precise64.box"
BOX_RAM = ENV['BOX_RAM'] || "512"

Vagrant.configure("2") do |config|
  config.vm.box = BOX_NAME
  config.vm.box_url = BOX_URI

  config.vm.network "private_network", ip: "192.168.59.101"

  config.vm.provider :virtualbox do |virtualbox|
    virtualbox.customize ["modifyvm", :id, "--name", "anderson-project"]
    virtualbox.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    virtualbox.customize ["modifyvm", :id, "--memory", BOX_RAM]
    virtualbox.customize ["setextradata", :id, "--VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  end

  config.vm.provision :docker, images: ["ubuntu:12.04"]

  config.vm.provision :shell, :path => "shell/build.sh"

  config.vm.provision :docker do |docker|
    docker.run "php54",
      image: "vagrant/php54",
      args: "-v /vagrant/www:/var/www -p 80:80"
  end

  config.ssh.username = "vagrant"
  config.ssh.shell = "bash -l"
  config.ssh.keep_alive = true
  config.ssh.forward_agent = false
  config.ssh.forward_x11 = false

  config.vagrant.host = :detect
end