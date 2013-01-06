class install_package {

}

define install_package::get(
	$version = '2.2.0', #version of archive
	$destination = '/usr/local', # directory to download archive file to
	$user = 'root', # user to carry out operations
	$url # url of archive file
	) {
	
	include install_package::dependencies

    # file { "$destination":
    #     ensure => 'directory',
    #     owner => "$user",
    #     group => "$user",
    #     mode => '0755'
    # }

    $base_url = "$url$name"
    
	include wget

    # todo only run wget if file is not present
	wget::fetch { "$name":
	  source => "$base_url-$version.zip",
	  destination => "/usr/local/$name-$version.zip",
	  timeout => 0,
	}

	exec { "unzip-$name":
		command => "unzip $name-$version.zip",
		cwd => "/usr/local",
		unless => "test -d /usr/local/$name-$version",
		# path => "/usr/bin:/usr/sbin:/bin",
		require => Wget::Fetch["$name"]
	}

	# uncomment when we find a way for wget not to run for unzip folder
	# exec { "rm-$name":
	# 	command => "rm $name-$version.zip",
	# 	cwd => "/usr/local",
	# 	# path => "/usr/bin:/usr/sbin:/bin",
	# 	unless => "test ! -f /usr/local/$name-$version.zip",
	# 	require => Exec["unzip-$name"]	
	# }

	$name_path = "\n export PATH=/usr/local/$name-$version/bin:$PATH"
	exec { "add-$name-to-path":
		command => "echo -e $name_path >> ~/.bashrc && echo -e $name_path >> ~/.zshrc",
		require => Exec["unzip-$name"] 
	}


}