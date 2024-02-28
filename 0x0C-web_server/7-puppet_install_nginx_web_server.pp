# Update package list
exec { 'apt-update':
  command     => '/usr/bin/apt-get -y update',
  refreshonly => true,
  before      => Package['nginx'],
}

# Install Nginx
package { 'nginx':
  ensure => installed,
}

# Ensure Nginx service is running
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}

# Define the content for the default server configuration
$server_config = "
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html;

    server_name _;

    location / {
        try_files \$uri \$uri/404;
        return 301 /redirected;
    }

    location = /redirected {
        rewrite ^ https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;
    }

    location /404 {
        return 404;
    }
}"

# Create the Nginx default server configuration file
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => $server_config,
  notify  => Service['nginx'],
}

# Create the Hello World index.html file
file { '/var/www/html/index.html':
  ensure  => present,
  content => 'Hello World!',
}

# Ensure Nginx listens on port 80
file_line { 'listen_on_port_80':
  ensure  => present,
  path    => '/etc/nginx/sites-available/default',
  line    => 'listen 80;',
  before  => 'server_name _;',
  require => Package['nginx'],
}
