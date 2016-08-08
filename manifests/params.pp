class conman::params {
  # borrowing liberally from https://github.com/ULHPC/puppet-conman/blob/devel/manifests/params.pp
  $service_enable = true
  $service_ensure = true
  $cfgfile = "/etc/conman.conf"
  $conman_server = $::fqdn
  $conman_port = '7890'
  $keepalive = true
  $loopback = false
  $tcpwrappers = false
  $resetcmd = ''
  $syslog = ''
  $timestamp = 0
  $log = ''
  $seropts = '9600,8n1'
  $ipmiopts = ''
}
