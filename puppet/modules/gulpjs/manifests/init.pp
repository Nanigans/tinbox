class gulpjs
{

  # https://github.com/gulpjs/gulp/blob/master/docs/getting-started.md

  exec
  {
    "install-gulp":
    command => "npm install -g gulp",
    require => Package["nodejs"]
  }

  exec
  {
    "install-node-modules":
    cwd     => "/var/www",
    command => "npm install",
    require => Exec["install-gulp"]
  }
}