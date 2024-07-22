# install flask from pip3
package { 'python3-pip':
  ensure => installed,
}

exec { 'install_flask':
  command     => '/usr/bin/pip3 install Flask==2.1.0',
  environment => ['PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],
  require     => Package['python3-pip'],
}

# Optional: Install additional dependencies that Flask might require
package { 'libssl-dev':
  ensure => installed,
}


