# mirror_repos

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with mirror_repos](#setup)
    * [Beginning with mirror_repos](#beginning-with-mirror_repos)
3. [Usage - Configuration options and additional functionality](#examples)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

`puppetlabs-apache` module if you want to manage vhost within this module.
apache module create a http proxy with fqdn of the hostname.

This module copy all available rpms from given repo_source using reposync and
then create repository using createrepo from all rpms.

It can, optionally, add needed files to allow PXE Boot using your mirror, and add needed files for security upgrades (on CentOS only).

## Setup
`include ::mirror_repos`

Repo configuration should be a Hash in following format
`mirror_repos::repos:` must be followed by `OS-ARCH` and then
name of the repo and configuration of repo

### Beginning with mirror_repos

Add the following in your class
`include ::mirror_repos`

This module copy a bash script `update-repos` to /usr/sbin.
This script runs every night to sync remote repos.
This script has many options, to know more do `/usr/sbin/update-repos -h`.

#### Examples

#####

It is highly recommended to define repos in Hiera.
```
mirror_repos::config_dir: '/etc/repos'
mirror_repos::repos_dir: '/n/repos'
mirror_repos::repos:
  centos7-x86_64:
    base:
      baseurl: 'http://mirrors.tripadvisor.com/centos/7/os/x86_64/'
      gpgkey: 'http://mirrors.tripadvisor.com/centos/7/os/x86_64/RPM-GPG-KEY-CentOS-7'
      enabled: 1
  centos6-x86_64:
    base:
      baseurl: 'http://mirror.centos.org/centos-6/6/os/x86_64/'
      enabled: 0
```

## Reference

#### Parameters

The following parameters are available in the `mirror_repos` class.

##### `packages`

Data type: `Array`



Default value: $mirror_repos::params::packages

##### `repos`

Data type: `Hash`



Default value: $mirror_repos::params::repos

##### `vhosts`

Data type: `Hash`


Default value: $mirror_repos::params::vhosts

##### `config_dir`

Data type: `String`


Default value: $mirror_repos::params::config_dir

##### `repos_dir`

Data type: `String`


Default value: $mirror_repos::params::repos_dir

##### `manage_vhost`

Data type: `Boolean`


Default value: $mirror_repos::params::manage_vhost

##### `delete`

Data type: `Boolean`


Default value: $mirror_repos::params::delete

Correspond to the `reposync` command's parameter `--delete`

##### `download_comps`

Data type: `Boolean`


Default value: $mirror_repos::params::download_comps

Correspond to the `reposync` command's parameter `--downloadcomps`

##### `download_metadata`

Data type: `Boolean`


Default value: $mirror_repos::params::download_metadata

Correspond to the `reposync` command's parameter `--downloadmetadata`

##### `gpg_check`

Data type: `Boolean`


Default value: $mirror_repos::params::gpg_check

Correspond to the `reposync` command's parameter `--gpgcheck`

##### `newest_only`

Data type: `Boolean`


Default value: $mirror_repos::params::newest_only

Correspond to the `reposync` command's parameter `--newestonly`

##### `pxeboot`

Data type: `Boolean`


Default value: $mirror_repos::params::pxeboot

Allow download files needed to perform a PxeBoot using this mirror (LiveOS folder and images folder inside os repository)

##### `cache_dir`

Data type: `String`


Default value: $mirror_repos::params::cache_dir

Correspond to the `createrepo` command's parameter `--cachedir`

##### `generate_updateinfo_url`

Data type: `String`


Default value: $mirror_repos::params::generate_updateinfo_url

Url used to download the python script `generate_updateinfo.py` you can find [here](https://github.com/vmfarms/generate_updateinfo)

### mirror_repos::apache

The mirror_repos::apache class.

### mirror_repos::config

== Class mirror_repos::config

This class is called from mirror_repos

### mirror_repos::install

The mirror_repos::install class.

### mirror_repos::params

The mirror_repos::params class.

## Limitations

This Module is tested on, CentOS7 an Debian. (I think it's not working anymore for RedHat clients and servers, due to specificities to create updateinfo.xml for CentOS)

## Development

For contributing Fork this module and open PR.

Authors
-------

Benjamin Mare <benjamin.mare@cea.fr>

Forked from:
------------
Bhanu Prasad G <gangurubhanu@gmail.com>

Copyright
---------
Copyright [2018] [Bhanu Prasad G]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
