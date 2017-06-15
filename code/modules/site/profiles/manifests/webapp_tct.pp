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


class profiles::webapp_tct(
  $www_dir = '/var/www',
) {

  include housekeeping
  include dltsyumrepo::development

  group {'dlib' :
    ensure => present,
    gid    => '200',
  }

  include tct



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
