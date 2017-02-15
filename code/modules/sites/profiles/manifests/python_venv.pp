#
class profiles::python_venv {

  package { 'python-virtualenv.noarch':
    ensure => installed,
  }

  user { 'loris' :
    ensure     => present,
    home       => '/home/loris',
    shell      => '/bin/bash',
  }
  file { '/var/www' :
    ensure => directory,
  }
  file { '/var/www/loris2' :
    ensure => directory,
    owner  => 'loris',
    group  => 'loris',
  }
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
    pkgname    => 'setuptools',
    virtualenv => 'system',
    owner      => 'root',
    timeout    => 1800,
  }
  python::pip { 'virtualenv':
    ensure     => latest,
    pkgname    => 'virtualenv',
    virtualenv => 'system',
    owner      => 'root',
    timeout    => 1800,
  }
  python::virtualenv { '/usr/local/python' :
    ensure     => present,
    version    => 'system',
    systempkgs => true,
    distribute => false,
    venv_dir   => '/usr/local/python',
    owner      => 'root',
    group      => 'root',
    cwd        => '/tmp',
    timeout    => 0,
    require    => Package['python-virtualenv.noarch'],
  }


}
