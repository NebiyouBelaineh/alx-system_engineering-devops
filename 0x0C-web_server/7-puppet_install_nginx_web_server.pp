# Script to install nginx and configure it on a new ubuntu server using Puppet

package {'nginx':
  ensure => 'present',
}

exec {'install_nginx':
  command  => 'sudo apt-get -y update ; sudo apt-get -y install nginx',
  provider => shell,

}

exec {'Hello World':
  command  => 'echo "Hello World!" > /var/www/html/index.nginx-debian.html',
  provider => shell,
}

exec {'Handle redirect_me':
  command  => 'sudo sed -i "53i\location =  /redirect_me { return 301 http://youtube.com;}" /etc/nginx/sites-enabled/default',
  provider => shell,
}

exec {'restart_nginx':
  command  => 'sudo service nginx restart',
  provider => shell,
}
