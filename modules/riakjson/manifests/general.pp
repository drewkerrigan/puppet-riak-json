# general
#
class riakjson::general
{
  exec { 'inital apt-get update': command => 'apt-get update'}

  -> package { 'install wget': ensure => present, name => 'wget' }
  -> package { 'install openjdk-7-jdk':        ensure => present, name => 'openjdk-7-jdk' }
  -> package { 'install libjansi-native-java': ensure => present, name => 'libjansi-native-java' }
  -> package { 'install libjansi-java':        ensure => present, name => 'libjansi-java' }

  -> package { 'install ntp': ensure => present, name => 'ntp' }
  -> service { 'ntp': ensure => running, enable => true }

  -> package { 'install git':     ensure => present, name => 'git' }
  -> package { 'install vim':     ensure => present, name => 'vim' }
  -> package { 'install openssl': ensure => present, name => 'openssl' }
  -> package { 'install curl':    ensure => present, name => 'curl' }

  -> exec { 'post-package apt-get update': command => 'apt-get update'}
}
