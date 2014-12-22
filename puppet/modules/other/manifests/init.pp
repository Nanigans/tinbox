class other
{
    package
    {
        ["curl", "sqlite", "vim", "git-core", "unzip", "bash"]:
            ensure  => present,
            require => Exec['apt-get update'],
            before => Apt::Ppa["ppa:webupd8team/java"],
    }
}
