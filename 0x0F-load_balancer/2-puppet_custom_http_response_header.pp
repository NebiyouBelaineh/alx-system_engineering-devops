# Puppet script that adds custome header to nginx server


exec { 'update':
  command => '/usr/bin/apt-get update',
}

package { 'nginx':
  ensure  => 'installed',
  require => Exec['update'],
}
exec {'nginx_conf_httpp_header':
  command => 'sudo sed -i "29i\ add_header X-Served-By \$HOSTNAME;" /etc/nginx/nginx.conf',
  require =>  Package['nginx'],
  path    => '/bin:/usr/bin',
}

exec {'nginx_default_http_header':
  command => 'sudo sed -i "51i\ add_header X-Served-By \$HOSTNAME;" /etc/nginx/sites-enabled/default',
  require =>  Package['nginx'],
  path    => '/bin:/usr/bin',
}

#augeas { 'nginx_http_header':
#  context => '/files/etc/nginx/nginx.conf',
#  changes => [
#  'set http[.]/add_header X-Served-By "$$HOSTNAME";',
#  ],
#  require => Package['nginx'],
#}

service { 'nginx':
  ensure    => 'running',
  enable    => true,
  subscribe => Package['nginx'],
  require   => Exec['nginx_default_http_header'],
}
