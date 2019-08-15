# @summary Manage conman
#
# @example
#   include ::conman
#
# @param server
#   Boolean that sets host to act as conman server
# @param client
#   Boolean that sets host to act as conman client
# @param ensure
#   Module ensure property
# @param conman_server
#   Hostname of conman server
# @param conman_port
#   The port for conman server
# @param cfgfile
#   The conman configuration file
# @param consoles
#   Hash of `conman::console` resources
# @param coredump
#   See conman.conf man page
# @param coredumpdir
#   See conman.conf man page
# @param execpath
#   See conman.conf man page
# @param keepalive
#   See conman.conf man page
# @param logdir
#   See conman.conf man page
# @param logfile
#   See conman.conf man page
# @param loopback
#   See conman.conf man page
# @param pidfile
#   See conman.conf man page
# @param resetcmd
#   See conman.conf man page
# @param syslog
#   See conman.conf man page
# @param tcpwrappers
#   See conman.conf man page
# @param timestamp
#   See conman.conf man page
# @param log
#   See conman.conf man page
# @param logopts
#   See conman.conf man page
# @param seropts
#   See conman.conf man page
# @param ipmiopts
#   See conman.conf man page
class conman (
  Boolean $server = true,
  Boolean $client = true,
  Enum['present', 'absent'] $ensure = 'present',
  Stdlib::Host $conman_server = $::fqdn,
  Stdlib::Port $conman_port = 7890,
  String $cfgfile = '/etc/conman.conf',
  Hash $consoles = {},
  # server config
  Boolean $coredump = false,
  Optional[Stdlib::Absolutepath] $coredumpdir = undef,
  Optional[String] $execpath = undef,
  Boolean $keepalive = true,
  Optional[Stdlib::Absolutepath] $logdir = undef,
  Optional[String] $logfile = undef,
  Boolean $loopback = false,
  Optional[Stdlib::Absolutepath] $pidfile = undef,
  Optional[String] $resetcmd = undef,
  Optional[String] $syslog = undef,
  Boolean $tcpwrappers = false,
  String $timestamp = '0',
  # global config
  Optional[String] $log = undef,
  Optional[String] $logopts = undef,
  String $seropts = '9600,8n1',
  Optional[String] $ipmiopts = undef,
) {

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
      mode      => '0640',
      show_diff => false,
      require   => Package['conman'],
    }
    concat::fragment { 'conman.conf.header':
      target  => $cfgfile,
      content => template('conman/etc/conman.conf.header.erb'),
      order   => '01',
    }
    $consoles.each |$console_name, $console| {
      conman::console { $console_name:
        * => $console,
      }
    }

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
