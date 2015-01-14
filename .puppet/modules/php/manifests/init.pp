# == Class: php
#
# Installs PHP5 and necessary modules. Sets config files.
#
class php {
  package { ['php5',
             'php5-cli',
             'libapache2-mod-php5',
             'php5-curl',
             'php5-gd',
             'php5-intl',
             'php5-json',
             'php5-mcrypt',
             'php5-mysql',
             'php5-sqlite',
             'php5-xmlrpc',
             'php5-xsl',
             'php5-xdebug']:
    ensure => present;
  }

  file {
    '/etc/php5/apache2':
      ensure => directory,
      before => File ['/etc/php5/apache2/php.ini'];

    '/etc/php5/apache2/php.ini':
      source  => 'puppet:///modules/php/php-apache2.ini',
      require => Package['php5'];

    '/etc/php5/cli':
      ensure => directory,
      before => File ['/etc/php5/cli/php.ini'];

    '/etc/php5/cli/php.ini':
      source  => 'puppet:///modules/php/php-cli.ini',
      require => Package['php5-cli'];
  }

  # Set root password
  exec { 'enable-pdo-mysql':
    command => 'php5enmod pdo_mysql',
    path    => ['/bin', '/usr/bin', '/usr/sbin'],
    require => Package['php5', 'php5-cli'],
    notify => Service['apache2'];
  }
}
