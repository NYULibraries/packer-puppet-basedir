# Class: tct::install
# ===========================
#
# Full description of class tct here.
#
#
# Examples
# --------
#
#
# Authors
# -------
#
# Flannon Jackson <flannon@nyu.edu>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class tct::install (
  $venv = '/usr/local/lib/virtualenv',
){

  # Setup python

  ensure_packages(['python34', 'python34-pip'], {'ensure' => 'present'})
  #ensure_packages(['centos-release-scl', 'python33'], 
  #                {'ensure'              => 'present'})
  # setup python
  class { 'python':
    version    => 'system',
    pip        => 'present',
    dev        => 'present',
    virtualenv => 'present',
    gunicorn   => 'absent',
    use_epel   => true,
  }->
  python::pip { 'pip':
    ensure     => latest,
    pkgname    => 'pip',
    virtualenv => 'system',
    owner      => 'root',
    timeout    => 1800,
  }->
  python::pip { 'virtualenv':
    ensure     => latest,
    pkgname     => 'virtualenv',
    virtualenv => 'system',
    owner      => 'root',
    timeout    => 1800,
  }->
  python::pip { 'setuptools':
    ensure     => latest,
    pkgname    => 'setuptools',
    virtualenv => 'system',
    owner      => 'root',
    timeout    => 1800,
  }
  python::virtualenv { $venv :
    ensure     => present,
    version    => '3',
    systempkgs => true,
    #venv_dir   => "/usr/local/lib/virtualenv",
    venv_dir   => $venv,
    owner      => 'root',
    group      => 'root',
    timeout    => 0,
    require => [ Class['python'], Package['python34'] ],
  }
  python::pip { 'psycopg2':
    ensure     => '2.7.1',
    pkgname    => 'psycopg2',
    virtualenv => $venv,
    owner      => 'root',
    timeout    => 1800,
    require    => Class['postgresql::server'],
  }
  file { "requirements.txt" :
    #path   => "/home/${user}/src/requirements.txt",
    ensure => present,
    path   => "${venv}/requirements.txt",
    owner  => 'root',
    group  => 'root',
    mode   => "0755",
    source => "puppet:///modules/tct/requirements.txt",
  }
  python::requirements { "${venv}/requirements.txt":
    virtualenv => $venv,
    owner      => 'root',
    group      => 'root',
    require    => Python::Virtualenv["${venv}"],
  }
  file { 'requirements-documentation.txt':
    ensure => present,
    path   => "${venv}/requirements-documentaiton.txt",
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => "puppet:///modules/tct/requirements-documentation.txt",
  }
  python::requirements { "${venv}/requirements-documentation.txt":
    virtualenv => $venv,
    owner      => 'root',
    group      => 'root',
    require    => Python::Virtualenv["${venv}"],
  }
  file { "requirements-testing.txt" :
    ensure => present,
    path   => "${venv}/requirements-testing.txt",
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => "puppet:///modules/tct/requirements-testing.txt",
  }

  #file { "NODESOURCE-GPG-SIGNING-KEY-EL":
  #  ensure => present,
  #  path   => '/etc/pki/rpm-gpg/NODESOURCE-GPG-SIGNING-KEY-EL',
  #  owner  => 'root',
  #  group  => 'root',
  #  mode   => '0644',
  #}

  #yumrepo { "nodesource":
  #  ensure   => present,
  #  descr    => 'Node.js Packages for Enterprise Linux 7 - $basearch',
  #  baseurl  => 'https://rpm.nodesource.com/pub_7.x/el/7/$basearch',
  #  enabled  => 1,
  #  gpgcheck => 1,
  #  #protect  => 0,
  #  #gpgkey   => 'file:///etc/pki/rpm-gpg/NODESOURCE-GPG-SIGNING-KEY-EL',
  #  gpgkey   => 'https://rpm.nodesource.com/pub/el/NODESOURCE-GPG-SIGNING-KEY-EL',
  #}
  #yumrepo { "nodesource-source":
  #  ensure   => present,
  #  descr    => 'Node.js for Enterprise Linux 7 - $basearch - Source',
  #  baseurl  => 'https://rpm.nodesource.com/pub_7.x/el/7/SRPMS',
  #  enabled  => 0,
  #  gpgcheck => 1,
  #  #protect  => 0,
  #  #gpgkey   => 'file:///etc/pki/rpm-gpg/NODESOURCE-GPG-SIGNING-KEY-EL',
  #  gpgkey   => 'https://rpm.nodesource.com/pub/el/NODESOURCE-GPG-SIGNING-KEY-EL',
  #}
  class {'nodejs':
    repo_url_suffix            => '7.x',
    nodejs_package_name        => 'nodejs-2:7.7.4-1nodesource.el7.centos.x86_64'
  }
  package { 'bower':
    ensure   => '1.8.0',
    provider => 'npm',
  }

}
