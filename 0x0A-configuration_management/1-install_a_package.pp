# install flask from pip3
package { 'python3-pip':
  ensure => installed,
}

exec { 'install_flask':
  command     => '/usr/bin/pip3 install Flask==2.1.0',
  environment => ['PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],
  require     => Package['python3-pip'],
  path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  unless      => '/usr/bin/pip3 show Flask | grep Version | grep -q 2.1.0',
}

file { '/etc/profile.d/flask.sh':
  ensure  => present,
  content => 'export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/flask_env/bin"',
  require => Exec['install_flask'],
}

exec { 'source_profile':
  command     => 'source /etc/profile.d/flask.sh',
  refreshonly => true,
  subscribe   => File['/etc/profile.d/flask.sh'],
}

exec { 'install_flask_in_virtualenv':
  command     => '/opt/flask_env/bin/pip install Flask==2.1.0',
  creates     => '/opt/flask_env/bin/flask',
  require     => Exec['source_profile'],
}





