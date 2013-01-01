# install gvm
class gvm::system {
exec { "system-gvm": 
  command => "curl -s get.gvmtool.net | bash",
  cwd => "/var/tmp",
  path => ["/usr/bin", "/usr/sbin", "/bin"],
  # require => [File['jdk_home']]
	}
}