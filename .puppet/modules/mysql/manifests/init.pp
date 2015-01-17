# == Class: mysql
#
# Installs MySQL server, sets config file, and loads database for dynamic site.
#
class mysql {

  $root_password = 'vagrant'
  $username = $::hostname
  $password = $::hostname
  $database = $::hostname

  package { ['mysql-server']:
    ensure => present
  }

  service { 'mysql':
    ensure  => running,
    require => Package['mysql-server']
  }

  file {
    '/etc/mysql/conf.d/optimized.cnf':
      content => template('mysql/optimized.cnf.erb'),
      owner => 'root',
      group => 'root',
      mode  => '0644',
      require => Package['mysql-server'],
      notify  => Service['mysql'];
  }

  # Set root password
  exec { 'set-root-password':
    unless  => "mysqladmin -uroot -p$root_password status",
    command => "mysqladmin -uroot password $root_password",
    path    => ['/bin', '/usr/bin'],
    require => Service['mysql']
  }

  # Create the database
  exec { 'create-database':
    unless  => "mysql -u root -p$root_password $database",
    command => "mysql -u root -p$root_password -e \"CREATE DATABASE $database;\"",
    path    => ['/bin', '/usr/bin'],
    require => Exec['set-root-password']
  }

  # Create the user
  exec { 'create-user':
    unless  => "mysql -u $username -p$password $database",
    command => "mysql -u root -p${root_password} -e \"GRANT ALL PRIVILEGES ON $database.* TO '$username'@'localhost' IDENTIFIED BY '$password';\"",
    path    => ['/bin', '/usr/bin'],
    require => Exec['create-database']
  }

  # Import database schema
  if file('/vagrant/build/db-schema.sql', '/dev/null') != '' {
    exec { 'import-schema':
      command => "mysql -u $username -p$password $database < /vagrant/build/db-schema.sql",
      path    => ['/bin', '/usr/bin'],
      require => Exec['create-user']
    }
  }
}
