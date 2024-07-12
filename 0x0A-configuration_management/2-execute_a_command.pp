# Puppet manifest to kill a process named killmenow using pkill

exec { 'killmenow':
  command     => '/usr/bin/pkill -TERM -f "killmenow"',
  path        => '/usr/bin',
  onlyif      => '/usr/bin/pgrep -f "killmenow"',
  refreshonly => true,
  notify      => Exec['check_process_stopped'],
}

exec { 'check_process_stopped':
  command     => '/usr/bin/pgrep -f "killmenow"',
  path        => '/usr/bin',
  onlyif      => '/usr/bin/pgrep -f "killmenow"',
  refreshonly => true,
  provider    => shell,
  unless      => '/usr/bin/pgrep -f "killmenow"',
}
