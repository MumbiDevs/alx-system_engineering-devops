# Puppet manifest to kill a process named killmenow using pkill

exec { 'pkill':
  command  => 'pkill killmenow',
  provider => 'shell',
}
