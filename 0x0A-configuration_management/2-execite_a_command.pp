# Puppet script that creates a manifest that kills a process named killmenow.

exec { 'killmenow_process':
    command => '/usr/bin/pkill killmenow',
    path    => ['/bin', '/usr/bin'],
}
