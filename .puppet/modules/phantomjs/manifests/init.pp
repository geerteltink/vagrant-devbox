# == Class: PhantomJS
#
# Installs packages for PhantomJS as a deamon.
#
class phantomjs {

  # Latest phantomjs version
  $latest_version = '1.9.8'
  $file_name = "phantomjs-${latest_version}-linux-x86_64"
  $download_url = "https://bitbucket.org/ariya/phantomjs/downloads/${file_name}.tar.bz2"

  package { ['libfontconfig1']:
    ensure => present
  }

  file { '/var/phantomjs':
    ensure => directory,
    before => Exec['phantomjs-retrieve'];
  }

  exec { 'phantomjs-retrieve':
    command => "wget $download_url -O /var/phantomjs/${file_name}.tar.bz2",
    path    => ['/bin', '/usr/bin'],
    creates => "/var/phantomjs/${file_name}.tar.bz2",
    require => Package['libfontconfig1'];
  }

  exec { 'phantomjs-unpack':
    command => "tar xjf /var/phantomjs/${file_name}.tar.bz2 -C /usr/share",
    path    => ['/bin', '/usr/bin'],
    creates => "/usr/share/${file_name}",
    require => Exec['phantomjs-retrieve'];
  }

  file { '/usr/local/share/phantomjs':
    ensure => 'link',
    force => true,
    target => "/usr/share/${file_name}/bin/phantomjs",
    require => Exec['phantomjs-unpack'];
  }

  file { '/usr/local/bin/phantomjs':
    ensure => 'link',
    force => true,
    target => "/usr/share/${file_name}/bin/phantomjs",
    require => Exec['phantomjs-unpack'];
  }

  file { '/usr/bin/phantomjs':
    ensure => 'link',
    force => true,
    target => "/usr/share/${file_name}/bin/phantomjs",
    require => Exec['phantomjs-unpack'];
  }

  # Create deamon
  file { '/etc/init.d/phantomjs':
    content => template('phantomjs/phantomjs-deamon.erb'),
    owner => 'root',
    group => 'root',
    mode  => '0755',
    require => [Exec['phantomjs-unpack'], File['/usr/bin/phantomjs']];
  }

  # Start deamon
  service { 'phantomjs':
    enable => true,
    ensure  => running,
    require => [Exec['phantomjs-unpack'], File['/etc/init.d/phantomjs']];
  }
}
