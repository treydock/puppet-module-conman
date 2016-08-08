# inspired by https://github.com/ULHPC/puppet-conman/blob/devel/manifests/console.pp
define conman::console(
  $device,
  $logfile = '',
  $logopts = '',
  $seropts = '',
  $ipmiopts = '',
  $cfgfile = $conman::params::cfgfile,
  $order = '50'
){
  concat::fragment { "conman.conf.$name":
    target  => $cfgfile,
    content => template("conman/etc/conman.conf.console.erb"),
    order   => $order,
  }
}
