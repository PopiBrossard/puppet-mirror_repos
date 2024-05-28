# Class: mirror_repos
# ===========================
#
# Full description of class mirror_repos here.
#
# Parameters
# ----------
#
# * `mirror_repos::vhost`
# create apache vhost with this name. Default is FQDN
#
# Variables
# ----------
#
# * `mirror_repos::config_dir`
# Where to deploy the repo configuration files.
# Default is `/etc/mirror.repos.d`
#
# * `mirror_repos::repos_dir`
# Where to store the mirrorred repos
# Default is `/repos`
#
# * `mirror_repos::repos`
# repositories to mirror
# Default is empty
#
# Examples
# ####
# --------
#
# @example
#    class { 'mirror_repos':
#      config_dir => '/etc/repos_conf',
#    }
#
#
class mirror_repos (
    Array $packages                 = $mirror_repos::params::packages,
    Hash $repos                     = $mirror_repos::params::repos,
    Hash $vhosts                    = $mirror_repos::params::vhosts,
    String $config_dir              = $mirror_repos::params::config_dir,
    String $repos_dir               = $mirror_repos::params::repos_dir,
    String $cron_user               = $mirror_repos::params::cron_user,
    Boolean $manage_vhost           = $mirror_repos::params::manage_vhost,
    Boolean $download_comps         = $mirror_repos::params::download_comps,
    Boolean $download_metadata      = $mirror_repos::params::download_metadata,
    Boolean $gpg_check              = $mirror_repos::params::gpg_check,
    Boolean $delete                 = $mirror_repos::params::delete,
    Boolean $newest_only            = $mirror_repos::params::newest_only,
    Optional[String] $cache_dir     = $mirror_repos::params::cache_dir,
    String $generate_updateinfo_url = $mirror_repos::params::generate_updateinfo_url,
    Boolean $pxeboot                = $mirror_repos::params::pxeboot,
  ) inherits mirror_repos::params {

    class { '::mirror_repos::install': }
    -> class { '::mirror_repos::config': }
    -> class { '::mirror_repos::apache': }
}
