#mirror_repos parameters
class mirror_repos::params {
  case $::osfamily {
    'RedHat': {
              $packages       = ['createrepo', 'yum-utils']
              $manage_vhost   = true
              $vhosts         = {}
              $config_dir     = '/etc/mirror.repos.d'
              $repos_dir      = '/repos'
              $repos          = {}
              $downloadcomps  = false
              $gpg_check      = true
              $delete          = false
              $newest_only     = false
    }
    'Debian': {
              $packages       = ['createrepo', 'yum-utils']
              $manage_vhost   = true
              $vhosts         = {}
              $config_dir     = '/etc/mirror.repos.d'
              $repos_dir      = '/repos'
              $repos          = {}
              $download_comps = false
              $gpg_check      = true
              $delete         = false
              $newest_only    = false
              $cache_dir      = undef
    }
    default: {
              fail("${::operatingsystem} not supported")
    }
  }
}
