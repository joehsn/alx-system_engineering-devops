# This Puppet manifest kills a process named 'killmenow' using pkill

exec { 'killmenow':
  command => 'pkill killmenow',
  path    => ['/bin', '/usr/bin'],  # Ensure path includes pkill's location
}

