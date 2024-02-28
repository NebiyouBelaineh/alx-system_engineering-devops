# install nginx and 
# return string "Hello World!" when quering the root
# rediretion must be a "301" move permanentyly

exec { 'apt-update':
  command     => '/usr/bin/apt-get -y update',
  refreshonly => true,
  before      => Package['nginx'],
}

package { 'nginx':
  ensure => installed,
}

service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}

file { '/var/www/html/index.html':
  ensure  => present,
  content => 'Hello World!',
}

$server_config = "
	server {
		listen 80 default_server;
		listen [::]:80 default_server;
		
		root /var/www/html;
		index index.html;

		server_name _;
		rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;

		location / {
			try_files \$uri \$uri/404;
		}
}"

file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => $server_config,
  notify  => Service['nginx'],
}
