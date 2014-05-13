class nodejs
{
  $packages = [
    "nodejs"
  ]

  # We have to install node via this apt repository because the Ubuntu 12 repo has nodejs 0.6 instead of 0.10.  Ouch.
  # https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager
  # This also installs npm in the process, so we don't need to do that separately.
  exec
  {
    "add-node-apt-repository":
    command => "add-apt-repository ppa:chris-lea/node.js",
    require => Package['python-software-properties']
  }

  package
  {
    $packages:
      ensure => latest,
      require => [Exec['add-node-apt-repository'], Exec['apt-get update']]
  }
}