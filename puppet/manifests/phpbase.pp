# Enable XDebug ("0" | "1")
$use_xdebug = "1"

# Default path
Exec
{
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

exec
{
    'apt-get update':
        command => '/usr/bin/apt-get update',
        require => Exec['add php55 apt-repo']
}

# create a simple hostname and ip host entry
host { 'adbox.nanigans.com':
  ip => '192.168.56.101',
  host_aliases => 'adbox',
}

include bootstrap
include other #curl and sqlite
include php55 #specific setup steps for 5.5
include php
include apache
include mysql
include redis
include memcached
include composer
include nodejs
include gulpjs

include laravel_app
