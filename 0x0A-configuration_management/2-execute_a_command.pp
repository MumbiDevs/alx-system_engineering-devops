exec { 'killmenow':
  command     => '/usr/bin/pkill -f "killmenow"',
  path        => '/usr/bin',
  onlyif      => '/usr/bin/pgrep -f "killmenow"',
  refreshonly => true,
}
