class gvm($version='latest', $install_rvm=true) {
	stage { 'gvm-install': before => Stage['main'] }

  if $install_rvm {
    class {
      'gvm::dependencies': stage => 'gvm-install';
      'gvm::system':       stage => 'gvm-install';
    }
  }
}