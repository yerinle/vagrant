class install_package::dependencies {
  if ! defined(Package['unzip'])           { package { 'unzip':             ensure => installed } }
}