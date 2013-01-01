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
