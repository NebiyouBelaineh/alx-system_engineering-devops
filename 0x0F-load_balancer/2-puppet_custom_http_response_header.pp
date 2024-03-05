# Puppet script that adds custome header to nginx server

exec {'update':
  command => '/usr/bin/apt-get update',
}
  package {'nginx':
  ensure => 'installed',
}
file_line { 'http_header':
  path   => '/etc/nginx/nginx.conf',
  line   => "http {\n\tadd_header X-Served-By \$HOSTNAME;",
  match  => 'http {',
}
exec {'run':
  command => '/usr/sbin/service nginx stop && /usr/sbin/service nginx start',
  path    => '/bin:/usr/bin:/usr/sbin',
}
