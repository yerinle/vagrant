include apt

group { "puppet":
     ensure => "present",
}
  
File { owner => 0, group => 0, mode => 0644 }

file { '/etc/motd':
    content => "Welcome to your Vagrant-built virtual machine!
                 Managed by Puppet.\n"
}

# ensure vim is present
package { "vim": 
  ensure => present 
}

exec { "apt-get update":
    command => "apt-get update",
    cwd => "/var/tmp",
    path    => ["/usr/bin", "/usr/sbin"]
  }
  
  apt::source { "partner":
    location => "http://archive.canonical.com/ubuntu",
    release => "${lsbdistcodename}",
    repos => "partner",
    include_src => false,
}

# package { jdk:
#   ensure => installed,
#   name => $operatingsystem? { 
#     centOS =>"java-1.6.0-openjdk-devel",
#     Ubuntu =>"openjdk-7-jdk",
#     default=>"jdk",
#   },
# }

# source => "puppet://$server/filesserver/sun-java6.preseed",

# file { "/var/cache/debconf/sun-java6.preseed":
#     source => "puppet:///modules/apt/files/etc/sun-java6.preseed",
#     ensure => present
# }


# file { "/var/cache/debconf/sun-java6.preseed":
#     ensure => present
# }

# package { "sun-java6-jdk":
#     ensure  => installed,
#     responsefile => "/var/cache/debconf/sun-java6.preseed",
#     require => [ Apt::Source["partner"], File["/var/cache/debconf/sun-java6.preseed"] ],
# }

# package { "openjdk-7-jdk":
#     ensure  => installed,
#     responsefile => "/var/cache/debconf/sun-java6.preseed",
#     require => [ Apt::Source["partner"], File["/var/cache/debconf/sun-java6.preseed"] ],
# }

package { "openjdk-7-jdk":
    ensure  => installed,
    require => [ Apt::Source["partner"]],
}