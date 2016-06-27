class conman inherits conman::params {
  # variables
  $service_enable = hiera('conman::service::enable',$conman::params::service_enable)
  $service_ensure = hiera('conman::service::ensure',$conman::params::service_ensure)
  $conman_server = hiera('conman::service::hostname',$conman::params::conman_server)
  $conman_port = hiera('conman::service::port',$conman::params::conman_port)
  $cfgfile = hiera('conman::cfg::cfgfile',$conman::params::cfgfile)
  $keepalive = hiera('conman::cfg::keepalive',$conman::params::keepalive)
  $loopback = hiera('conman::cfg::loopback',$conman::params::loopback)
  $resetcmd = hiera('conman::cfg::resetcmd',$conman::params::resetcmd)
  $timestamp = hiera('conman::cfg::timestamp',$conman::params::timestamp)
  $serialopts = hiera('conman::cfg::serialopts',$conman::params::serialopts)
  $ipmiopts = hiera('conman::cfg::ipmiopts',$conman::params::ipmiopts)

  # packages
  package { "conman":
    ensure => present,
  }

  # if possibly running the service
  if ( $service_enable or $service_ensure ) {
    # config file
    concat { $cfgfile:
      ensure => present,
      owner   => root,
      group   => root,
      mode    => 0644,
      require => Package["conman"],
    }
    concat::fragment { "conman.conf.header":
      target  => $cfgfile,
      content => template("conman/conman.conf.header.erb"),
      order   => 01,
    }
    # service
    service { "conman":
      enable    => $service_enable,
      ensure    => $service_ensure,
      require   => Concat[$cfgfile],
      subscribe => Concat[$cfgfile]
    }
  } else {
    # config file
    file { $cfgfile:
      ensure  => absent,
      require => Package["conman"],
    }
    # service
    service { "conman":
      enable    => $service_enable,
      ensure    => $service_ensure,
      require   => File[$cfgfile],
    }
  }

  # environment files
  file { "/etc/profile.d/conman.sh":
    ensure  => present,
    content => template("conman/etc/conman.sh.erb"),
    owner   => root,
    group   => root,
    mode    => 0644,
  }
  file { "/etc/profile.d/conman.csh":
    ensure  => present,
    content => template("conman/etc/conman.csh.erb"),
    owner   => root,
    group   => root,
    mode    => 0644,
  }
}
