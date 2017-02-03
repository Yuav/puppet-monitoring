# Class: monitoring::monitoring::hekad
#
# @author Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
# @see https://onpuppet.github.io/puppet-monitoring Monitoring
#
# @param plugins_location [String] Location of sensu plugins. Default value: /opt/sensu/embedded/bin/
#
class monitoring::monitoring::sensu::hekad (String $plugins_location,) {
  sensu::check { 'hekad-process': command => "${plugins_location}check-process.rb --pattern hekad --warn-under 1", }
}
