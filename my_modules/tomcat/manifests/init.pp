class tomcat {

	include install_package

	install_package::get { "apache-tomcat":
		version => '7.0.34',
		url => "http://mirror.ox.ac.uk/sites/rsync.apache.org/tomcat/tomcat-7/v7.0.34/bin/",
		name => 'apache-tomcat'
	}

}