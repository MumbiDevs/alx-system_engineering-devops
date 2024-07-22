# install flask from pip3
package { 'python3-pip':
  ensure => installed,
}

package { 'python3-venv':
  ensure => installed,
}

exec { 'create_flask_env':
  command => '/usr/bin/python3 -m venv /opt/flask_env',
  creates => '/opt/flask_env/bin/activate',
}

exec { 'install_flask':
  command     => '/opt/flask_env/bin/pip install Flask==2.1.0',
  environment => ['PATH=/opt/flask_env/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],
  require     => Exec['create_flask_env'],
}

