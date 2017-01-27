Puppet Monitoring
=================

[![Build Status](https://travis-ci.org/Yuav/puppet-monitoring.svg)](https://travis-ci.org/Yuav/puppet-monitoring)

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with monitoring](#setup)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Module to install monitoring for any detected service supported

## Module Description

Detects installed services by using custom facts. This enables complete decoupling of monitoring from deployment of services.
The module provides a highly opinionated monitoring client setup, and assumes the existence of server side components being available.

With the help of [yuav-refacter](https://github.com/Yuav/puppet-refacter), the services installed during the same run will cause facts refresh prior to installing monitoring tools

Decoupling monitoring module from other modules is useful in order to avoid adding monitoring code
into the modules themselves. The module will magically install monitoring of everything installed on a machine without any
hard dependencies between the module that install the service and the monitoring module.

## Setup

Install the module using:
```puppet
puppet module install yuav-monitoring
```

## Usage

```puppet
class { 'monitoring':
  collectd_network_server_hostname => 'influxdb',
  sensu_rabbitmq_hostname => 'sensu.server',
  sensu_rabbitmq_password => 'pass',
}
```
This will install CollectD and Sensu, and report to 'influxdb' and 'sensu.server' respectively.

 * CollectD will get installed only if collectd_network_server_hostname is set
 * Sensu will get installed only if sensu_rabbitmq_hostname is set

## Reference

### CollectD plugins

Default:
 * cpu
 * disk
 * df
 * fhcount
 * interface
 * load
 * memory
 * uptime

If present:
 * apache (if statuspage is enabled)
 * ntpd
 * rabbitmq (if management interface enabled)
 * redis

### Sensu plugins

Default:
  * cpu
  * memory
  * disk
  * load
  * filesystem
  * process
  * network

If present:
  * centrify
  * collectd
  * elasticsearch
  * influxdb
  * mysql
  * postfix
  * rabbitmq
  * redis

### Custom Facts

This module relies on a set of custom facts to detect any services installed. These facts are refreshed at the end
of any ordinary Puppet run using the yuav-refacter module. This ensures that if another module installs any of these
services, the fact values will be updated to reflect this new state before installing monitoring plugins

#### Apache facts

Checks if Apache is installed on the system
```puppet
$::apache_present
```

Checks if apache status page with metrics is available from localhost
```puppet
$::apache_statuspage_present
```

#### Centrify facts
Checks if Centrify is installed on the system
```puppet
$::centrify_present
```

#### CollectD facts
Checks if CollectD is installed on the system
```puppet
$::collectd_present
```

#### ElasticSearch facts
Checks if ElasticSearch is installed on the system
```puppet
$::elasticsearch_present
```

#### InfluxDB facts
Checks if InfluxDB is installed on the system
```puppet
$::influxdb_present
```

#### Mysql facts
Checks if Mysql is installed on the system
```puppet
$::mysql_present
```

#### NTPD facts

Checks if ntpd is installed on the system
```puppet
$::ntpd_present
```

#### Postfix facts
Checks if Postfix is installed on the system
```puppet
$::postfix_present
```

#### RabbitMQ facts

Checks if RabbitMQ is installed on the system
```puppet
$::rabbitmq_present
```
Retrieves RabbitMQ management port if enabled
```puppet
$::rabbitmq_management_port
```
#### Redis facts

Checks if Redis is installed on the system
```puppet
$::redis_present
```

## Limitations

If you are running through a Puppet master, and are deploying services using Puppet - monitoring will not detect this service until the next run
due to a limitation in Yuav-refacter module. Running in a masterless setup however, will work as expected.

## Contributing

See CONTRIBUTING.md
