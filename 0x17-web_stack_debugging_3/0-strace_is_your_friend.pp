# Pupper script that replaces the typo to fix apache 2 internal server problem error

exec {'replace':
  provider => shell,
  command  => 'sed -i "s/phpp/php/g" /var/www/html/wp-settings.php'
}
