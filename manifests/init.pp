#
class conman (
  Boolean $server = true,
  Boolean $client = true,
  Enum['present', 'absent'] $ensure = 'present',
  String $conman_server = $::fqdn,
  Integer $conman_port = 7890,
  String $cfgfile = '/etc/conman.conf',
  Boolean $keepalive = true,
  Boolean $loopback = false,
  Boolean $tcpwrappers = false,
  String $resetcmd = '',
  String $logfile = '',
  String $syslog = '',
  String $timestamp = '0',
  String $log = '',
  Boolean $coredump = false,
  String $coredumpdir = '',
  String $seropts = '9600,8n1',
  String $ipmiopts = '',
  Hash $consoles = {},
) inherits conman::params {

  if $ensure == 'present' {
    $package_ensure = 'present'
    $file_ensure    = 'file'
    if $server {
      $service_ensure = 'running'
      $service_enable = true
    } else {
      $service_ensure = 'stopped'
      $service_enable = false
    }
  } else {
    $package_ensure = 'absent'
    $file_ensure    = 'absent'
    $service_ensure = 'stopped'
    $service_enable = false
  }

  package { 'conman':
    ensure => $package_ensure,
  }

  if $server {
    concat { $cfgfile:
      ensure    => $ensure,
      owner     => 'root',
      group     => 'root',
      mode      => '0644',
      show_diff => false,
      require   => Package['conman'],
    }
    concat::fragment { 'conman.conf.header':
      target  => $cfgfile,
      content => template('conman/etc/conman.conf.header.erb'),
      order   => '01',
    }
    create_resources('conman::console', $consoles)

    service { 'conman':
      ensure     => $service_ensure,
      enable     => $service_enable,
      hasrestart => true,
      hasstatus  => true,
      subscribe  => Concat[$cfgfile],
    }
  } else {
    service { 'conman':
      ensure  => $service_ensure,
      enable  => $service_enable,
      require => Package['conman'],
    }

    file { '/etc/profile.d/conman.sh':
      ensure  => $file_ensure,
      content => template('conman/etc/profile.d/conman.sh.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }
    file { '/etc/profile.d/conman.csh':
      ensure  => $file_ensure,
      content => template('conman/etc/profile.d/conman.csh.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }
  }

}
