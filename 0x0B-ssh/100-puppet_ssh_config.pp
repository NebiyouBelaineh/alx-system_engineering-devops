# This script uses Puppet to make changes to our configuration file.
# SSH client configuration must be configured to use the private key 
# ~/.ssh/school
# SSH client configuration must be configured to refuse to authenticate using 
# a password
include stdlib

file_line { 'Delare identity file':
  ensure  => present,
  path    => '/etc/ssh/ssh_config',
  line    => '     IdentityFile ~/.ssh/school',
  replace => true,
}

file_line{ 'Turn off passwd':
  ensure  => present,
  path    => '/etc/ssh/ssh_config',
  line    => '   PasswordAuthentication no',
  replace => true,
}
