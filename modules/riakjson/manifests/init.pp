# riakjson
#
class riakjson(
  $nodename= 'localhost',     #Hostname of this node
)
{

  include riakjson::params
  include riakjson::general
  include riakjson::riak

  Class['riakjson']
    -> Class['riakjson::params']
    -> Class['riakjson::general']
    -> Class['riakjson::riak']


  # default exec settings
  Exec {
    path        => ['/usr/bin','/usr/sbin', '/bin/', '/sbin/'],
    user        => 'root',
    group       => 'root',
    logoutput   => 'on_failure',
    cwd         => '/tmp'
  }

}