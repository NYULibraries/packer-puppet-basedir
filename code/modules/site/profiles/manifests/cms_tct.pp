# == Class: profile::cms_tct
#
# Full description of class profile here.
#
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#


class profiles::cms_tct(
  $www_dir = '/var/www',
) {

  include housekeeping
  include dltsyumrepo::development

  group {'dlib' :
    ensure => present,
    gid    => '200',
  }

  # setup python
  class { 'python':
    version    => 'system',
    pip        => 'present',
    dev        => 'present',
    virtualenv => 'present',
    gunicorn   => 'absent',
    use_epel   => true,
  }
  python::pip { 'pip':
    ensure     => latest,
    pkgname    => 'pip',
    virtualenv => 'system',
    owner      => 'root',
    timeout    => 1800,
  }
  python::pip { 'setuptools':
    ensure     => latest,
    pkgname     => 'setuptools',
    virtualenv => 'system',
    owner      => 'root',
    timeout    => 1800,
  }
  python::pip { 'virtualenv':
    ensure     => latest,
    pkgname     => 'virtualenv',
    virtualenv => 'system',
    owner      => 'root',
    timeout    => 1800,
  }

  #file { "${www_dir}/virtualenv" :
  #  ensure => directory,
  #  owner  => 'root',
  #  group  => 'root',
  #  mode   => '0755',
  #}

    python::virtualenv { "${www_dir}/virtualenv" :
    ensure     => present,
    version    => 'system',
    systempkgs => true,
    venv_dir   => "${www_dir}/virtualenv",
    owner      => $loris_owner,
    group      => $loris_group,
    timeout    => 0,
    #require    => Package['python-virtualenv.noarch'],
  }

#  python::pip { "${www_dir}/virtualenv Werkzeug":
#    ensure     => present,
#    pkgname    => 'Werkzeug',
#    virtualenv => "${www_dir}/virtualenv",
#    owner      => 'loris',
#    #owner      => 'root',
#    timeout    => 1800,
#  }
#  python::pip { "${www_dir}/virtualenv Pillow":
#    ensure     => present,
#    pkgname    => 'Pillow',
#    virtualenv => "${www_dir}/virtualenv",
#    owner      => $loris_owner,
#    timeout    => 1800,
#  }
#  file { "${www_dir}/src":
#    ensure => directory,
#    owner  => $loris_owner,
#    group  => $loris_group,
#    mode   => '0755',
#  }

  include nginx
  nginx::resource::server { 'tct.local':
    www_root =>  '/var/www/tct.local',
  }
    
  firewall { '100 allow apache access on 80' :
    dport  => [80, 443],
    proto  => tcp,
    action => accept,
  }


  # postgres
  include postgresql::server
  postgresql::server::db { 'testdb':
    user     => 'testy',
    password => postgresql_password('testy', 'letmein'),
  }
  postgresql::server::role { 'tct':
    password_hash => postgresql_password('tct', 'letmeout'),
  }
  postgresql::server::database_grant {'testy':
    privilege => 'ALL',
    db        => 'testdb',
    role      => 'tct',
  }

}
