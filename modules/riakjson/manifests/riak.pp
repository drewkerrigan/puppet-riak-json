# riak
#
class riakjson::riak
{
  exec { 'force limits.conf reload on login':
   command => "echo 'session    required   pam_limits.so' >> /etc/pam.d/common-session",
   cwd => $params::work_dir
  }

  ->
  file { '/etc/security/limits.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    content => template('riakjson/riak/limits.conf.erb')
  }

  ->
  group { 'riak':
    ensure => present,
    system => true,
    gid      => '640'
  }

  ->
  user { 'riak':
    ensure  => ['present'],
    system => true,
    password => '!!',
    uid      => '640',
    gid      => '640',
    shell    => '/bin/bash',
    home    => '/var/lib/riak',
    require => [
      Group['riak']
    ]
  }

  ->
  file { "${params::work_dir}/riak_${params::riak_version}.deb":
    source => "puppet:///modules/riakjson/riak/riak_${params::riak_version}.deb"
  }

  ->
  exec { 'install riakjson':
   command => "dpkg -i riak_${params::riak_version}.deb",
   creates => '/var/lib/riak',
   cwd => $params::work_dir,
   path    => ['/usr/bin', '/bin', "/usr/local/bin", "/usr/local/sbin", "/usr/sbin", "/sbin"]
  }

  # configure
  ->
  file { '/etc/riak/riak.conf':
    mode    => '0644',
    content => template('riakjson/riak/riak.conf.erb'),
    owner   => 'riak',
    group   => 'riak',
    replace => true,
  }

  ->
  service { 'riak':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    require    => [
      User['riak']
    ]
  }
}