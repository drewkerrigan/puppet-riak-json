puppet-riak-json
================

## Create a Debian Package for RiakJson

```
cd vagrant/packager-riakjson
vagrant up --provision
```

Once it completes, run `vagrant ssh` to log into the VM and run the following to make the files available for download:

```
cd /tmp/riak/package/packages && python -m SimpleHTTPServer 8000
```

Download the `.deb` and `.sha` from `http://localhost:8000/` on the host machine.

## Start a single node RiakJson instance

```
cd vagrant/onenode-riakjson
vagrant up --provision
```