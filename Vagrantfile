Vagrant.configure("2") do |config|
  # Enable hostmanager to automatically update /etc/hosts on host machine
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true

  # ====================
  # DB VM: MariaDB
  # ====================
  config.vm.define "db01" do |db01|
    db01.vm.box = "centos/stream9"
    db01.vm.hostname = "db01"
    db01.vm.network "private_network", ip: "192.168.56.15"
    db01.vm.provider "virtualbox" do |vb|
      vb.memory = 512    # 512 MB RAM
      vb.cpus = 1       # 1 CPU core
    end
    db01.vm.provision "shell", inline: <<-SHELL
      sudo dnf update -y
      sudo dnf install -y epel-release
      sudo dnf install -y git mariadb-server
      sudo systemctl enable --now mariadb
    SHELL
  end

  # ====================
  # Memcached VM
  # ====================
  config.vm.define "mc01" do |mc01|
    mc01.vm.box = "centos/stream9"
    mc01.vm.hostname = "mc01"
    mc01.vm.network "private_network", ip: "192.168.56.14"
    mc01.vm.provider "virtualbox" do |vb|
      vb.memory = 512    # 512 MB RAM
      vb.cpus = 1       # 1 CPU core
    end
    mc01.vm.provision "shell", inline: <<-SHELL
      sudo dnf update -y
      sudo dnf install -y epel-release
      sudo dnf install -y memcached
      sudo systemctl enable --now memcached
    SHELL
  end

  # ====================
  # RabbitMQ VM
  # ====================
  config.vm.define "rmq01" do |rmq01|
    rmq01.vm.box = "centos/stream9"
    rmq01.vm.hostname = "rmq01"
    rmq01.vm.network "private_network", ip: "192.168.56.13"
    rmq01.vm.provider "virtualbox" do |vb|
      vb.memory = 512    # 512 MB RAM
      vb.cpus = 1       # 1 CPU core
    end
    rmq01.vm.provision "shell", inline: <<-SHELL
      sudo dnf update -y
      sudo dnf install -y epel-release wget
      sudo dnf install -y centos-release-rabbitmq-38
      sudo dnf --enablerepo=centos-rabbitmq-38 -y install rabbitmq-server
      sudo systemctl enable --now rabbitmq-server
    SHELL
  end

  # ====================
  # App VM: Java, Git, Wget, Maven tools
  # ====================
  config.vm.define "app01" do |app01|
    app01.vm.box = "centos/stream9"
    app01.vm.hostname = "app01"
    app01.vm.network "private_network", ip: "192.168.56.12"
    app01.vm.provider "virtualbox" do |vb|
      vb.memory = 1024   # 1 GB RAM
      vb.cpus = 2       # 2 CPU cores
    end
    app01.vm.provision "shell", inline: <<-SHELL
      sudo dnf update -y
      sudo dnf install -y epel-release
      sudo dnf install -y java-17-openjdk java-17-openjdk-devel git wget vim unzip
    SHELL
  end

  # ====================
  # Web VM: Ubuntu + Nginx
  # ====================
  config.vm.define "web01" do |web01|
    web01.vm.box = "ubuntu/jammy64"
    web01.vm.hostname = "web01"
    web01.vm.network "private_network", ip: "192.168.56.11"
    web01.vm.provider "virtualbox" do |vb|
      vb.gui = true       # No GUI for resource savings
      vb.memory = 2024     # ~2 GB RAM
      vb.cpus = 2          # 2 CPU cores
    end
    web01.vm.provision "shell", inline: <<-SHELL
      sudo apt update -y
      sudo apt upgrade -y
      sudo apt install -y nginx vim unzip
    SHELL
  end
end
