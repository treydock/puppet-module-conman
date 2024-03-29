# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

* [`conman`](#conman): Manage conman

### Defined types

* [`conman::console`](#conmanconsole): Define a conman console

## Classes

### <a name="conman"></a>`conman`

Manage conman

#### Examples

##### 

```puppet
include ::conman
```

#### Parameters

The following parameters are available in the `conman` class:

* [`server`](#server)
* [`ensure`](#ensure)
* [`conman_server`](#conman_server)
* [`conman_port`](#conman_port)
* [`cfgfile`](#cfgfile)
* [`consoles`](#consoles)
* [`manage_repo`](#manage_repo)
* [`coredump`](#coredump)
* [`coredumpdir`](#coredumpdir)
* [`execpath`](#execpath)
* [`keepalive`](#keepalive)
* [`logdir`](#logdir)
* [`logfile`](#logfile)
* [`loopback`](#loopback)
* [`pidfile`](#pidfile)
* [`resetcmd`](#resetcmd)
* [`syslog`](#syslog)
* [`tcpwrappers`](#tcpwrappers)
* [`timestamp`](#timestamp)
* [`log`](#log)
* [`logopts`](#logopts)
* [`seropts`](#seropts)
* [`ipmiopts`](#ipmiopts)

##### <a name="server"></a>`server`

Data type: `Boolean`

Boolean that sets host to act as conman server

Default value: ``true``

##### <a name="ensure"></a>`ensure`

Data type: `Enum['present', 'absent']`

Module ensure property

Default value: `'present'`

##### <a name="conman_server"></a>`conman_server`

Data type: `Stdlib::Host`

Hostname of conman server

Default value: `$facts['networking']['fqdn']`

##### <a name="conman_port"></a>`conman_port`

Data type: `Stdlib::Port`

The port for conman server

Default value: `7890`

##### <a name="cfgfile"></a>`cfgfile`

Data type: `String`

The conman configuration file

Default value: `'/etc/conman.conf'`

##### <a name="consoles"></a>`consoles`

Data type: `Hash`

Hash of `conman::console` resources

Default value: `{}`

##### <a name="manage_repo"></a>`manage_repo`

Data type: `Boolean`

Manage repo to install conman, only used on EL8

Default value: ``true``

##### <a name="coredump"></a>`coredump`

Data type: `Boolean`

See conman.conf man page

Default value: ``false``

##### <a name="coredumpdir"></a>`coredumpdir`

Data type: `Optional[Stdlib::Absolutepath]`

See conman.conf man page

Default value: ``undef``

##### <a name="execpath"></a>`execpath`

Data type: `Optional[String]`

See conman.conf man page

Default value: ``undef``

##### <a name="keepalive"></a>`keepalive`

Data type: `Boolean`

See conman.conf man page

Default value: ``true``

##### <a name="logdir"></a>`logdir`

Data type: `Optional[Stdlib::Absolutepath]`

See conman.conf man page

Default value: ``undef``

##### <a name="logfile"></a>`logfile`

Data type: `Optional[String]`

See conman.conf man page

Default value: ``undef``

##### <a name="loopback"></a>`loopback`

Data type: `Boolean`

See conman.conf man page

Default value: ``false``

##### <a name="pidfile"></a>`pidfile`

Data type: `Optional[Stdlib::Absolutepath]`

See conman.conf man page

Default value: ``undef``

##### <a name="resetcmd"></a>`resetcmd`

Data type: `Optional[String]`

See conman.conf man page

Default value: ``undef``

##### <a name="syslog"></a>`syslog`

Data type: `Optional[String]`

See conman.conf man page

Default value: ``undef``

##### <a name="tcpwrappers"></a>`tcpwrappers`

Data type: `Optional[Boolean]`

See conman.conf man page

Default value: ``undef``

##### <a name="timestamp"></a>`timestamp`

Data type: `String`

See conman.conf man page

Default value: `'0'`

##### <a name="log"></a>`log`

Data type: `Optional[String]`

See conman.conf man page

Default value: ``undef``

##### <a name="logopts"></a>`logopts`

Data type: `Optional[String]`

See conman.conf man page

Default value: ``undef``

##### <a name="seropts"></a>`seropts`

Data type: `String`

See conman.conf man page

Default value: `'9600,8n1'`

##### <a name="ipmiopts"></a>`ipmiopts`

Data type: `Optional[String]`

See conman.conf man page

Default value: ``undef``

## Defined types

### <a name="conmanconsole"></a>`conman::console`

Define a conman console

#### Examples

##### 

```puppet
conman::console { 'compute01':
  device   => 'ipmi:bmc-compute01',
  ipmiopts => 'U:admin,P:bmcpassword',
}
```

#### Parameters

The following parameters are available in the `conman::console` defined type:

* [`device`](#device)
* [`log`](#log)
* [`logopts`](#logopts)
* [`seropts`](#seropts)
* [`ipmiopts`](#ipmiopts)
* [`order`](#order)

##### <a name="device"></a>`device`

Data type: `String`

The console device, maps to `dev` in conman.conf

##### <a name="log"></a>`log`

Data type: `Optional[String]`

See conman.conf man page

Default value: ``undef``

##### <a name="logopts"></a>`logopts`

Data type: `Optional[String]`

See conman.conf man page

Default value: ``undef``

##### <a name="seropts"></a>`seropts`

Data type: `Optional[String]`

See conman.conf man page

Default value: ``undef``

##### <a name="ipmiopts"></a>`ipmiopts`

Data type: `Optional[String]`

See conman.conf man page

Default value: ``undef``

##### <a name="order"></a>`order`

Data type: `String`

The order of where to insert file in conman.conf
The default will order alphabetically by name

Default value: `'50'`

