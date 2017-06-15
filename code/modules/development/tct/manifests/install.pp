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
  $user = 'tct',
){

  # Make the user
  user { $user :
    ensure     => present,
    comment    => "Topic Creation Toolkit",
    home       => "/home/${$user}",
    managehome =>  true,
  }

  file { "/home/${user}/src" :
    ensure => directory,
    owner  => $user,
    group  => $user,
    mode   =>  '0755',
  }


  # Setup python

  ensure_packages(['python34'], {'ensure' => 'present'})
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
  ##python::virtualenv { "${www_dir}/virtualenv" :
  ##  ensure                              => present,
  ##  version                             => '3',
  ##  systempkgs                          => true,
  ##  venv_dir                            => "${www_dir}/virtualenv",
  ##  owner                               => $user,
  ##  group                               => $user,
  ##  timeout                             => 0,
  ##}
  python::virtualenv { "/usr/local/lib/virtualenv" :
    ensure     => present,
    version    => '3',
    systempkgs => true,
    venv_dir   => "/usr/local/lib/virtualenv",
    owner      => 'root',
    group      => 'root',
    timeout    => 0,
    require => [ Class['python'], Package['python34'] ],
  }

  file { "requirements.txt" :
    path   => "/home/${user}/src/requirements.txt",
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => "0755",
    source => "puppet:///modules/tct/requirements.txt",
  }

  #python::requirements { "/home/${user}/src/requirements.txt":
  #  virtualenv => '/usr/local/lib/virtualenv',
  #  owner      => 'root',
  #  group      => 'root',
  #  require    => Python::Virtualenv['/usr/local/lib/virtualenv'],
  #}

  file { "/home/${user}/src/requirements-documentation.txt" :
    ensure => present,
    owner  => $user,
    group  => $user,
    mode   => "0755",
    source => "puppet:///modules/tct/requirements-documentation.txt",
  }

  file { "/home/${user}/src/requirements-testing.txt" :
    ensure => present,
    owner  => $user,
    group  => $user,
    mode   => "0755",
    source => "puppet:///modules/tct/requirements-testing.txt",
  }

}
