# puppet-module-conman

[![Puppet Forge](http://img.shields.io/puppetforge/v/treydock/conman.svg)](https://forge.puppetlabs.com/treydock/conman)
[![Build Status](https://travis-ci.org/osc/puppet-module-conman.png)](https://travis-ci.org/osc/puppet-module-conman)

####Table of Contents

1. [Setup - The basics of getting started with conman](#setup)
    * [What conman affects](#what-conman-affects)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Reference - Module reference](#reference)

## Setup

### What conman affects

This module will install and configure [ConMan: The Console Manager](https://github.com/dun/conman).

## Usage

Install and configure conman and define a console

```puppet
include ::conman
conman::console { 'compute01':
  device   => 'ipmi:bmc-compute01',
  ipmiopts => 'U:admin,P:bmcpassword',
}
```

To configure a system as a conman client:

```puppet
class { '::conman':
  server        => false,
  conman_server => 'conman.example.com',
}
```

This is an example of exporting console configurations for all physical servers:

```puppet
if $facts['virtual'] == 'physical' {
  @@conman::console { $::hostname:
    device => "ipmi:bmc-${::hostname}",
  }
}
```

Then collect all the exported consoles:

```puppet
Conman::Console <<| |>>
```

## Reference

[http://treydock.github.io/puppet-module-conman/](http://treydock.github.io/puppet-module-conman/)
