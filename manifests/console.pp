# inspired by https://github.com/ULHPC/puppet-conman/blob/devel/manifests/console.pp
define conman::console(
  $consolename,
  $consoledevice,
  $cfgfile = $conman::params::cfgfile,
  $logfile = '',
  $logopts = '',
  $seropts = '',
  $ipmiopts = '',
  $order = '50'
){
  concat::fragment { "conman.conf.$consolename":
    target  => $cfgfile,
    content => template("conman/etc/conman.conf.console.erb"),
    order   => $order,
  }
}
