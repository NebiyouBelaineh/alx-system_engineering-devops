# Script that installs flask from pip3
# Version must be 2.1.0
exec { 'install_flask':
    command => '/usr/bin/pip3 install flask==2.1.0',
    path    => ['/usr/bin'],
    creates => '/usr/local/lib/python3.8/dist-packages/flask', # Adjust the path based on your Python environment
  }
