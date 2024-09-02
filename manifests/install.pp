#class to install packages
class mirror_repos::install {
  package { $mirror_repos::packages:
    ensure => present,
  }
  file { '/usr/bin/generate_updateinfo':
    ensure => file,
    source => $mirror_repos::generate_updateinfo_url,
    mode   => '0755',
    owner  => 'root',
  }
}
