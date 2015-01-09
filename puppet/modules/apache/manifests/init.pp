# == Class: apache
#
# Installs packages for Apache2, enables modules, and sets config files.
#
class apache {
  package { ['apache2', 'apache2-mpm-prefork']:
    ensure => present;
  }

  service { 'apache2':
    ensure  => running,
    require => Package['apache2'];
  }

  file { '/var/www':
    ensure => 'link',
    target => '/vagrant',
    force => true,
  }

  apache::conf { ['apache2.conf',
                  'envvars',
                  'ports.conf',
                  'sites-available/000-default.conf']:
  }
}
