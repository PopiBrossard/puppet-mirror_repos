#mirror_repos parameters
class mirror_repos::params {
  case $::osfamily {
    'RedHat': {
              $packages                 = ['createrepo', 'yum-utils']
              $manage_vhost             = true
              $vhosts                   = {}
              $config_dir               = '/etc/mirror.repos.d'
              $repos_dir                = '/repos'
              $repos                    = {}
              $download_comps           = false
              $download_metadata        = false
              $gpg_check                = true
              $delete                   = false
              $newest_only              = false
              $cache_dir                = undef
              $generate_updateinfo_url  = 'https://raw.githubusercontent.com/vmfarms/generate_updateinfo/master/generate_updateinfo.py'
              $pxeboot                  = false
    }
    'Debian': {
              $packages                 = ['createrepo', 'yum-utils']
              $manage_vhost             = true
              $vhosts                   = {}
              $config_dir               = '/etc/mirror.repos.d'
              $repos_dir                = '/repos'
              $repos                    = {}
              $download_comps           = false
              $download_metadata        = false
              $gpg_check                = true
              $delete                   = false
              $newest_only              = false
              $cache_dir                = undef
              $generate_updateinfo_url  = 'https://raw.githubusercontent.com/vmfarms/generate_updateinfo/master/generate_updateinfo.py'
              $pxeboot                  = false
    }
    default: {
              fail("${::operatingsystem} not supported")
    }
  }
}
