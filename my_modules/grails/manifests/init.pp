class grails {

	include install_package

	install_package::get { "grails":
		version => '2.2.0',
		url => "http://dist.springframework.org.s3.amazonaws.com/release/GRAILS/",
		name => 'grails'
	}

}