# This Puppet manifest creates a file named /tmp/school with specific permissions and content

file { '/tmp/school':
  ensure  => present,
  mode    => '0744',
  owner   => 'www-data',
  group   => 'www-data',
  content => 'I love Puppet\n',  # Add a newline character at the end
}

