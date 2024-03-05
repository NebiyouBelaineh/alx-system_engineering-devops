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

exec {'sudo sed -i "s/listen 80 default_server;/listen 80 default_server;\\n\\tlocation = \/redirect_me {\\n\\t\\t
return 301 https:\/\/youtube.com\/;\\n\\t}/" /etc/nginx/sites-enabled/default':
  provider => shell,
}

exec {'restart_nginx':
  command  => 'sudo service nginx restart',
  provider => shell,
}
