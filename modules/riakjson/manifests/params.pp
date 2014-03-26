# params
#
class riakjson::params
{
  $work_dir= '/tmp'

  # Riak / RiakJson
  $riak_version= '2.0.0pre19-d30c0ac8-1_amd64'

  # limits.conf
  $riak_ulimit = 4096

  # riak.conf
  # Use 'leveldb' if not using RiakJson for metadata
  $riak_backend = 'bitcask'
  $riak_log_level = 'debug'
}
