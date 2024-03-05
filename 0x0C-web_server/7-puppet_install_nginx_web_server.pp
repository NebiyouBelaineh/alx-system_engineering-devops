# Ensure Nginx package is present
package { 'nginx':
  ensure => 'present',
}

# Update package repositories and install Nginx
exec { 'install_nginx':
  command     => 'apt-get -y update && apt-get -y install nginx',
  path        => '/usr/bin',  # Specify the path to ensure proper execution
  refreshonly => true,        # Only run when notified
  subscribe   => Package['nginx'],  # Subscribe to the 'nginx' package
}

# Create the Hello World index page
file { '/var/www/html/index.nginx-debian.html':
  ensure  => 'file',
  content => 'Hello World!',
  notify  => Exec['restart_nginx'],  # Notify to restart Nginx when the file changes
}

# Configure the redirect_me location in Nginx
exec { 'handle_redirect_me':
  command     => 'sed -i "/server_name _;$/a\ \ \ \ \ \ \ \ rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;" /etc/nginx/sites-available/default',
  path        => '/bin:/usr/bin',  # Specify the path to ensure proper execution
  refreshonly => true,           # Only run when notified
  subscribe   => Package['nginx'],  # Subscribe to the 'nginx' package
  notify      => Exec['restart_nginx'],  # Notify to restart Nginx when the configuration changes
}

# Restart Nginx service
exec { 'restart_nginx':
  command     => '/usr/sbin/service nginx restart',
  path        => '/usr/sbin:/usr/bin:/sbin:/bin',  # Specify the path to ensure proper execution
  refreshonly => true,  # Only run when notified
  subscribe   => Package['nginx'],  # Subscribe to the 'nginx' package
}
