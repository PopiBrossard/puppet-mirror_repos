# == Class mirror_repos::config
#
# This class is called from mirror_repos
#
class mirror_repos::config {
  #just replicate yum.repos.d
  file { [ $mirror_repos::config_dir, $mirror_repos::repos_dir ]:
    ensure => directory,
  }
  #create a dir for each OS and then a file for each repo under that OS
  $mirror_repos::repos.each |String $os_name , $repos_os | {
    $os = regsubst(regsubst($os_name, '[-]', '_', 'G'), '[/]', '_', 'G')
    file {"${mirror_repos::config_dir}/${os}.repo":
      ensure  => 'file',
      mode    => '0644',
      content => template('mirror_repos/repo.conf.erb'),
    }
  }
  $oses = keys($mirror_repos::repos)
  #copy file to update repos to localhost
  file { '/usr/sbin/update-repos':
    ensure  => file,
    mode    => '0755',
    content => template('mirror_repos/update-repos.sh.erb'),
  }
  if ($mirror_repos::download_comps) {
    $download_comps_string = '--downloadcomps '
  } else {
    $download_comps_string = ''
  }
  if ($mirror_repos::download_metadata) {
    $download_metadata_string = '--download-metadata '
  } else {
    $download_metadata_string = ''
  }
  if (!$mirror_repos::gpg_check) {
    $gpg_check_string = '--no-gpgcheck '
  } else {
    $gpg_check_string = ''
  }
  if ($mirror_repos::delete) {
    $delete_string = '--delete '
  } else {
    $delete_string = ''
  }
  if ($mirror_repos::newest_only) {
    $newest_only_string = '--newest-only '
  } else {
    $newest_only_string = ''
  }
  if ($mirror_repos::cache_dir) {
    $cache_dir_string = "--cachedir ${mirror_repos::cache_dir}"
  } else {
    $cache_dir_string = ''
  }
  $options = "${download_comps_string}${download_metadata_string}${gpg_check_string}${delete_string}${newest_only_string}${cache_dir_string}"
  #run cron every night to update repos
  cron { 'update-repos':
    command => " ( /usr/bin/time /usr/sbin/update-repos -v ${options} ) 2>&1 | /usr/bin/logger -t mirror_repos",
    user    => $mirror_repos::cron_user,
    hour    => 1,
    minute  => 0,

    require => File['/usr/sbin/update-repos'],
  }
}
