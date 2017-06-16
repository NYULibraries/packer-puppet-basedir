# Class: tct::install::backend
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
class tct::install::backend (
  $backend     = $tct::params::backend,
  $frontend    = $tct::params::frontend,
  $install_dir = $tct::params::install_dir,
  $user        = $tct::params::user,
  $venv        = $tct::params::venv,
  $db_user     = $tct::params::db_user,
  $db_password = $tct::params::db_password,
  $db_host     = $tct::params::db_host,
  $tct_db      = $tct::params::tct_db,
  $secret_key  = $tct::params::secret_key,
) inherits tct::params {

  # postgres
  include postgresql::server
  postgresql::server::db { $tct_db:
    user     => $db_user,
    password => postgresql_password($db_user, $db_password),
  }
  postgresql::server::role { 'tct_role':
    password_hash => postgresql_password('tct_role', '$db_password'),
  }
  postgresql::server::database_grant {$db_user:
    privilege => 'ALL',
    db        => $tct_db,
    role      => 'tct_role',
  }

  # Load backend database production_settings
  file { 'production_settings.py':
    ensure  => file,
    path    => "${install_dir}/${backend}/nyu/production_settings.py",
    require => Vcsrepo["${install_dir}/${backend}"],
    content => template('tct/production_settings.py.erb'),
  }
  file { 'secret_keys.json':
    ensure  => file,
    path    => "${install_dir}/${backend}/nyu/secret_keys.json",
    require => Vcsrepo["${install_dir}/${backend}"],
    content => template('tct/secret_keys.json.erb'),
  }

  # Hold hour nose, do the exec thing and run the python installer,
  #  python manage.py loaddata indexpatterns.json
  # see: dlts-enm-tct-backend/documentation/site/setup/index.html


}
