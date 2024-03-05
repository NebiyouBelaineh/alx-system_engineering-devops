# Setup New Ubuntu server with nginx
# and add a custom HTTP header

exec { 'update system':
  command => '/usr/bin/apt-get update',
}

package { 'nginx':
  ensure  => 'installed',
  require => Exec['update system'],
}

file { '/var/www/html/index.html':
  content => 'Hello World!',
}

exec { 'redirect_me':
  command  => 'sed -i "53i\\location =  /redirect_me { return 301 http://youtube.com;}" /etc/nginx/sites-enabled/default',
  provider => 'shell',
}

exec { 'error_page':
  command => 'printf "Ceci n\'est pas une page\n" > /usr/share/nginx/html/404.html',
}

exec { 'error_page_conf':
  command  => 'sed -i "53i\\    error_page 404 /404.html;\n    location = /404.html {\n      root /usr/share/nginx/html;\n      internal;}"
 /etc/nginx/sites-enabled/default',
  provider => 'shell',
}

exec { 'HTTP header':
  command  => 'sed -i "51i\\     add_header X-Served-By $HOSTNAME;" /etc/nginx/sites-enabled/default',
  provider => 'shell',
}

exec { 'HTTP header conf':
  command  => 'sed -i "29i\\     add_header X-Served-By $HOSTNAME;" /etc/nginx/nginx.conf',
  provider => 'shell',
}

service { 'nginx':
  ensure  => 'running',
  require => Package['nginx'],
}
