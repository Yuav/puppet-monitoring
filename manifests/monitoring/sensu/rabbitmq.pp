# Class: monitoring::monitoring::rabbitmq
#
# @author Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
# @see https://yuav.github.io/puppet-monitoring Monitoring
#
# @param plugins_location [String] Location of sensu plugins. Default value: /opt/sensu/embedded/bin/
#
class monitoring::monitoring::sensu::rabbitmq ($plugins_location = '/opt/sensu/embedded/bin/',) {
  if !defined(Package['g++']) {
    package { 'g++': ensure => 'present', }
  }

  if !defined(Package['make']) {
    package { 'make': ensure => 'present', }
  }

  package { 'sensu-plugins-rabbitmq':
    ensure   => 'present',
    provider => sensu_gem,
    require  => [Package['make'], Package['g++']],
  }

  sensu::check { 'rabbitmq-amqp-alive': command => "${plugins_location}check-rabbitmq-amqp-alive.rb", }

  if $::rabbitmq_management_present {
    sensu::check { 'rabbitmq-alive': command => "${plugins_location}check-rabbitmq-alive.rb", }

    sensu::check { 'rabbitmq-cluster-health': command => "${plugins_location}check-rabbitmq-cluster-health.rb", }

    sensu::check { 'rabbitmq-messages': command => "${plugins_location}check-rabbitmq-messages.rb", }

    sensu::check { 'rabbitmq-network-partitions': command => "${plugins_location}check-rabbitmq-network-partitions.rb", }

    sensu::check { 'rabbitmq-node-health': command => "${plugins_location}check-rabbitmq-node-health.rb", }
  }
}
