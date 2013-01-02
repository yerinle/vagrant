

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
    path    => ["/usr/bin", "/usr/sbin"]
}

# ensure vim is present
package { "vim": 
  ensure => present 
}

# install open jdk 7
package { jdk:
  ensure => installed,
  name => $operatingsystem? { 
    centOS =>"java-1.7.0-openjdk-devel",
    Ubuntu =>"openjdk-7-jdk",
    default=>"jdk",
  },
}

file {jdk_home: 
    path => "/etc/profile.d/set_java_home.sh",
    ensure => present,
    content => "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64",
    require => Package['jdk']
}

# ensure git is present
package { git:
  ensure => present
}

# ensure unzip is present
package { unzip:
  ensure => present
}

# ensure curl is present
package { curl:
  ensure => present
}

# install oh my zsh
package { zsh:
  ensure => present
}

exec { "curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh":
  cwd => "/var/tmp",
  path => ["/usr/bin", "/usr/sbin", "/bin"],
  require => PACKAGE['curl', 'zsh', 'git']
}

include gvm
