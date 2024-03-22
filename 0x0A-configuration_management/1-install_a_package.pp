# This Puppet manifest installs Flask version 2.1.0 using pip3

class { 'python::pip': }  # Ensure pip is available

package { 'Flask':
  ensure   => present,
  provider => 'pip3',
  require  => Class['python::pip'],
  version  => '2.1.0',
}

