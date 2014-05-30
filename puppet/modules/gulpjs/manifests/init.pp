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
    "install-gulp-save-dev":
    command => "/bin/sh -c 'cd /var/www && npm install --save-dev gulp'",
    require => Exec["install-gulp"]
  }

  exec
  {
    "install-gulp-minify-css":
    command => "npm install -g gulp-minify-css",
    require => Exec["install-gulp-save-dev"]
  }

  exec
  {
    "install-gulp-uglify":
    command => "npm install -g gulp-uglify",
    require => Exec["install-gulp-save-dev"]
  }

  exec
  {
    "install-gulp-concat":
    command => "npm install -g gulp-concat",
    require => Exec["install-gulp-save-dev"]
  }

  exec
  {
    "install-gulp-less-sourcemap":
    command => "npm install -g gulp-less-sourcemap",
    require => Exec["install-gulp-save-dev"]
  }

  exec
  {
    "install-gulp-ignore":
    command => "npm install -g gulp-ignore",
    require => Exec["install-gulp-save-dev"]
  }

  exec
  {
    "install-gulp-livereload":
    command => "npm install -g gulp-livereload",
    require => Exec["install-gulp-save-dev"]
  }
  
  exec
  {
    "install-gulp-autoprefixer":
    command => "npm install -g gulp-autoprefixer",
    require => Exec["install-gulp-save-dev"]
  }
}