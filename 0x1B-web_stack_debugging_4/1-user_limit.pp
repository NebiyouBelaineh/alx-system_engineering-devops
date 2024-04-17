# Puppet script that fixes hard and soft limit set on holberton user

exec{'hange-os-configuration-for-holberton-user-hard':
  provider => shell,
  command  => 'sed -i \'s/holberton hard nofile 5/holberton hard nofile 65536/\' /etc/security/limits.conf'
}
exec{'Change-os-configuration-for-holberton-user-soft':
  provider => shell,
  command  => 'sed -i \'s/holberton soft nofile 4/holberton soft nofile 65536/\' /etc/security/limits.conf'
}
