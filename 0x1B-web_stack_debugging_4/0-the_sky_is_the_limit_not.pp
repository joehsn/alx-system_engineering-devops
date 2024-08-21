# Increases the amount of traffic an Nginx server can handle by adjusting file descriptors limit

# Increase the ULIMIT of the default file
exec { 'increase-ulimit-for-nginx':
  command => 'sed -i "s/15/4096/" /etc/default/nginx',
  path    => '/usr/local/bin/:/bin/',
  unless  => 'grep -q "4096" /etc/default/nginx',
} ->

# Restart Nginx to apply changes
exec { 'nginx-restart':
  command => 'nginx restart',
  path    => '/etc/init.d/',
}
