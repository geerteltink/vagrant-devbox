# == Class: apache
#
# Installs packages for Apache2, enables modules, and sets config files.
#
class apache {
  package { ['apache2', 'apache2-mpm-prefork']:
    ensure => present
  }

  service { 'apache2':
    ensure  => running,
    require => Package['apache2']
  }

  file { '/var/www':
    ensure => 'link',
    target => '/vagrant',
    require => Package['apache2'],
    notify => Service['apache2'],
    replace => yes,
    force => true
  }

  file { '/var/www/html':
    ensure => 'absent',
    force => true
  }

  apache::conf { ['apache2.conf',
                  'envvars',
                  'ports.conf',
                  'sites-available/000-default.conf']:
  }
}
