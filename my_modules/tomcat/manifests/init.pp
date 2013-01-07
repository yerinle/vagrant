class tomcat {

	include install_package

	$version = '7.0.34'
	$my_name = 'apache-tomcat'

	install_package::get { "$my_name":
		version => "$version",
		url => "http://mirror.ox.ac.uk/sites/rsync.apache.org/tomcat/tomcat-7/v7.0.34/bin/",
		name => "$my_name"
	}

	exec { "make-$my_name-script-executable":
		command => "chmod +x *.sh",
		cwd => "/usr/local/$my_name-$version/bin",
		require => Install_package::Get["$my_name"] 
	}

}