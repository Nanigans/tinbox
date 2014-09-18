class gulpjs
{

  # https://github.com/gulpjs/gulp/blob/master/docs/getting-started.md

  exec
  {
    "install-node-modules":
    cwd     => "/var/www",
    command => "npm install --save-dev",
    require => Package["nodejs"]
  }
}