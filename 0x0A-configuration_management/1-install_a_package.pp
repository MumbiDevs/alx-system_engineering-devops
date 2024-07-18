#!/usr/bin/puppet

# Ensure Python 3 and pip3 are installed
package { 'python3':
  ensure => installed,
}

package { 'python3-pip':
  ensure => installed,
  require => Package['python3'],
}

# Install Flask version 2.1.0
exec { 'install_flask':
  command => '/usr/bin/pip3 install Flask==2.1.0',
  path    => ['/usr/bin', '/usr/local/bin'],
  unless  => '/usr/bin/pip3 show Flask | grep -q "Version: 2.1.0"',
  require => Package['python3-pip'],
}

# Verify Flask installation
exec { 'verify_flask':
  command => '/usr/bin/python3 -c "import flask; print(flask.__version__)"',
  path    => ['/usr/bin', '/usr/local/bin'],
  require => Exec['install_flask'],
}

# Create the file /tmp/school with the specified content, mode, owner, and group
file { '/tmp/school':
  content => 'I love Puppet',
  mode    => '0744',
  owner   => 'www-data',
  group   => 'www-data',
  require => Exec['install_flask'],
}
