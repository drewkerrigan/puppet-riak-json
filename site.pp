class onenode_riakjson {
  class{'riakjson': nodename => 'localhost'}
  include riakjson
}

class packager_riakjson {
  include packager
}

node 'riakjsononenode' {
  include onenode_riakjson
}

node 'riakjsonpackager' {
  include packager_riakjson
}