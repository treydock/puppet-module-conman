# @summary Define a conman console
#
# @example
#   conman::console { 'compute01':
#     device   => 'ipmi:bmc-compute01',
#     ipmiopts => 'U:admin,P:bmcpassword',
#   }
#
# @param device
#   The console device, maps to `dev` in conman.conf
# @param log
#   See conman.conf man page
# @param logopts
#   See conman.conf man page
# @param seropts
#   See conman.conf man page
# @param ipmiopts
#   See conman.conf man page
# @param order
#   The order of where to insert file in conman.conf
#   The default will order alphabetically by name
define conman::console (
  String $device,
  Optional[String] $log = undef,
  Optional[String] $logopts = undef,
  Optional[String] $seropts = undef,
  Optional[String] $ipmiopts = undef,
  String $order = '50',
) {

  include conman

  concat::fragment { "conman.conf.${name}":
    target  => $conman::cfgfile,
    content => template('conman/etc/conman.conf.console.erb'),
    order   => $order,
  }
}
