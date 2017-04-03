# inspired by https://github.com/ULHPC/puppet-conman/blob/devel/manifests/console.pp
define conman::console (
  String $device,
  String $logfile = '',
  String $logopts = '',
  String $seropts = '',
  String $ipmiopts = '',
  String $order = '50',
) {

  include conman

  $cfgfile = $conman::cfgfile

  concat::fragment { "conman.conf.${name}":
    target  => $cfgfile,
    content => template('conman/etc/conman.conf.console.erb'),
    order   => $order,
  }
}
