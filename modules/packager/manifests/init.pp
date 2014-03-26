# packager
#
class packager
{
  # default exec settings
  Exec {
    path        => ['/usr/bin','/usr/sbin', '/bin/', '/sbin/'],
    user        => 'root',
    group       => 'root',
    logoutput   => 'on_failure',
    cwd         => '/tmp'
  }

  $tmp = '/tmp'

  exec { 'inital apt-get update': command => 'apt-get update'}

  -> package { 'install build-essential':  ensure => present, name => 'build-essential' }
  -> package { 'install libncurses5-dev':  ensure => present, name => 'libncurses5-dev' }
  -> package { 'install openssl':          ensure => present, name => 'openssl' }
  -> package { 'install libssl-dev':       ensure => present, name => 'libssl-dev' }
  -> package { 'install fop':              ensure => present, name => 'fop' }
  -> package { 'install xsltproc':         ensure => present, name => 'xsltproc' }
  -> package { 'install unixodbc-dev':     ensure => present, name => 'unixodbc-dev' }
  -> package { 'install git':              ensure => present, name => 'git' }
  -> package { 'install libc6-dev-i386':   ensure => present, name => 'libc6-dev-i386' }
  -> package { 'install devscripts':       ensure => present, name => 'devscripts' }
  -> package { 'install debhelper':        ensure => present, name => 'debhelper' }
  -> package { 'install libpam0g-dev':     ensure => present, name => 'libpam0g-dev' }

  -> exec { 'post-packages update': command => 'apt-get update'}

  -> exec { 'erlang download':
    command => 'wget http://erlang.org/download/otp_src_R16B02.tar.gz && tar zxvf otp_src_R16B02.tar.gz',
    creates => "${tmp}/otp_src_R16B02",
    cwd => $tmp
  }

  ->  exec { 'erlang install':
    command => './configure && make && sudo make install',
    creates => '/usr/bin/erl',
    cwd => "${tmp}/otp_src_R16B02",
    path    => ['/usr/bin', '/bin', "${tmp}/otp_src_R16B02"]
  }

  -> exec { 'download riak':
    command => 'git clone https://github.com/basho/riak.git',
    creates => "${tmp}/riak",
    cwd => $tmp
  }

  -> exec { 'make package':
    command => 'git checkout ack-riak-json && make package RELEASE=1',
    creates => '/tmp/riak/package/packages',
    cwd => "${tmp}/riak",
    timeout     => 1800,
    path    => ['/usr/bin', '/bin', "/usr/local/bin"]
  }

}