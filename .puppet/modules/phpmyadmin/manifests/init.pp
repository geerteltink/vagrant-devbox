# == Class: phpmyadmin
#
# Installs PhpMyAdmin and sets config file.
#

class phpmyadmin {

  package { 'phpmyadmin':
    ensure => present,
  }

  file { '/etc/apache2/sites-enabled/001-phpmyadmin.conf':
    ensure  => link,
    target  => '/etc/phpmyadmin/apache.conf',
    require => Package['apache2', 'php5'],
    notify  => Service['apache2'],
  }
}
