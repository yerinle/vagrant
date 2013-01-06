# install gvm
class gvm::system {

exec { "get-gvm-script":
	command => "curl -s get.gvmtool.net > /var/tmp/gvm_install.sh",
	cwd => "/var/tmp",
  	user => "vagrant",
  	group => "vagrant",
  	path => ["/usr/bin", "/usr/sbin", "/bin"]
}

file { "/var/tmp/gvm_install.sh":
	mode => 744,
	owner => "vagrant",
	group => "vagrant",
	require => Exec['get-gvm-script']
}

exec { "install-gvm":
	command => "/bin/bash /etc/profile.d/set_java_home.sh && /bin/bash /var/tmp/gvm_install.sh",
	cwd => "/var/tmp",
	# user => "vagrant",
	logoutput => true,
	path => ["/usr/bin", "/usr/sbin", "/bin"],
	# environment => "JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64"
	require => [File['/var/tmp/gvm_install.sh'], File['jdk_home']]
}

$enable_gvm = "sudo -i && /bin/bash /root/.gvm/bin/gvm-init.sh"

exec { "source-gvm": 
	command => "$enable_gvm",
	cwd => "/var/tmp",
	# user => "vagrant",
	logoutput => true,
	path => ["/usr/bin", "/usr/sbin", "/bin"],
	require => Exec['install-gvm']

}

exec { "install-grails":
	command => "$enable_gvm && bash /root/.gvm/src/gvm-main.sh && gvm install grails",
	cwd => "/var/tmp",
	logoutput => true,
	path => ["/usr/bin:/usr/sbin:/bin:/root/.gvm/bin:/root/.gvm/ext"],
	require => Exec['source-gvm']

}

}