# == Class: PhantomJS
#
# Installs packages for PhantomJS as a deamon.
#
class phantomjs {
  package { ['phantomjs', 'libfontconfig1']:
    ensure => present
  }

  file {
    '/etc/init.d/phantomjs':
      content => template('phantomjs/phantomjs-deamon.erb'),
      owner => 'root',
      group => 'root',
      mode  => '0755',
      require => Package['phantomjs'];
  }

  service { 'phantomjs':
    enable => true,
    ensure  => running,
    require => File['/etc/init.d/phantomjs'];
  }
}
