
 # move to site.pp
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

group { "puppet":
     ensure => "present",
}
  
File { owner => 0, group => 0, mode => 0644 }

file { '/etc/motd':
    content => "Welcome to your Vagrant-built virtual machine!
                 Managed by Puppet.\n"
}

# refresh package manager libraries
  exec { "apt-get update":
      command => "apt-get update",
      cwd => "/var/tmp",
      path    => ["/usr/bin", "/usr/sbin"],
      before => Class['java']
}

# export jdk home
  file {jdk_home: 
      path => "/etc/profile.d/set_java_home.sh",
      ensure => present,
      content => "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64",
      require => Class['java']
  }

include java
# include gvm
# include grails

include tomcat

tomcat::instance {"foa_tomcat":
  ensure    => present,
  http_port => "80",
}

include jenkins

# # ensure vim is present
# package { "vim": 
#   ensure => present 
# }

# # ensure git is present
# package { git:
#   ensure => present
# }

# # ensure unzip is present
# package { unzip:
#   ensure => present
# }

# # ensure curl is present
# package { curl:
#   ensure => present
# }

# # install oh my zsh
# package { zsh:
#   ensure => present
# }

# exec { "curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh":
#   cwd => "/var/tmp",
#   path => "/usr/bin:/usr/sbin:/bin",
#   user => "vagrant",
#   group => "vagrant",
#   require => PACKAGE['curl', 'zsh', 'git']
# }


# OH MY ZSH CUSTOM INSTALL

# $my_name = "vagrant"

# if(!defined(Package["git-core"])) {
#       package { "git-core":
#         ensure => present,
#       }
#     }
#     exec { "chsh -s $path $my_name":
#       path => "/bin:/usr/bin",
#       unless => "grep -E '^${name}.+:${$path}$' /etc/passwd",
#       require => Package["zsh"]
#     }

#     package { "zsh":
#       ensure => latest,
#     }

#     if(!defined(Package["curl"])) {
#       package { "curl":
#         ensure => present,
#       }
#     }

#     exec { "copy-zshrc":
#       path => "/bin:/usr/bin",
#       cwd => "/home/$my_name",
#       user => $my_name,
#       command => "cp .oh-my-zsh/templates/zshrc.zsh-template .zshrc",
#       unless => "ls .zshrc",
#       require => Exec["clone_oh_my_zsh"],
#     }

#     exec { "clone_oh_my_zsh":  
#       path => "/bin:/usr/bin",
#       cwd => "/home/$my_name",
#       user => $my_name,
#       command => "git clone https://github.com/robbyrussell/oh-my-zsh.git /home/$my_name/.oh-my-zsh",
#       creates => "/home/$my_name/.oh-my-zsh",
#       require => [Package["git-core"], Package["zsh"], Package["curl"]],
#     }

# OH MY ZSH CUSTOM INSTALL END  

