# Pupper script that changes the limit for current maximum number of files opened for a shell session.

exec{'replace':
  provider => shell,
  command  => 'sed -i \'s/ULIMIT="-n 15"/ULIMIT="-n 4096"/\' /etc/default/nginx ; service nginx restart'
}
