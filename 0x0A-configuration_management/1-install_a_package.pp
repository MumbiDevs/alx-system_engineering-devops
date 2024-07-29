# Ensure Python 3.8 is installed using the system package manager
package { 'python3.8':
  ensure => installed,
}

# Ensure pip is installed using the system package manager
package { 'python3-pip':
  ensure  => installed,
  require => Package['python3.8'],
}

# Install Flask using pip3
package { 'Flask':
  ensure    => '2.1.0',
  provider  => 'pip3',
  require   => Package['python3-pip'],
}

# Install Werkzeug using pip3 and ensure it requires Flask
package { 'Werkzeug':
  ensure    => '2.1.1',
  provider  => 'pip3',
  require   => Package['Flask'],
}
