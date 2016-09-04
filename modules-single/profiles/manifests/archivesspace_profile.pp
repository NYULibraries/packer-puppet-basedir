#
class profiles::archivesspace_profile (
  $db          = hiera('archivesspace::db',
      $archivesspace::params::db),
  $db_passwd   = hiera('archivesspace::db_passwd',
      $archivesspace::params::db_passwd),
  $db_user     = hiera('archivesspace::db_user',
      $archivesspace::params::db_user),
  $install_dir = $archivesspace::params::install_dir,
  $user        = hiera('archivesspace::user',
      $archivesspace::params::user),

) inherits archivesspace::params {


  include dltsyumrepo::development
  #include dltsyumrepo::dlts
  #include java
  class { 'java':
    package => 'java-1.8.0-openjdk',
  }
  include archivesspace
  archivesspace::plugin { 'nyu_marcxml_export_plugin' :
    ensure        => 'present',
    plugin        => 'nyu_marcxml_export_plugin',
    plugin_source => 'https://github.com/NYULibraries/nyu_marcxml_export_plugin.git',
    plugin_conf   => 'AppConfig[:plugins] = [\'nyu_marcxml_export_plugin\']'
  }
  firewall { '100 allow http and https access':
      dport   => [80,8080, 8089, 8090, 8091 ],
      proto   => tcp,
      action  => accept,
  }
  firewall { '102 forward port 80 to 8080':
   table   => 'nat',
   chain   => 'PREROUTING',
   iniface => 'eth0',
   proto   => 'tcp',
   dport   => '80',
   jump    => 'REDIRECT',
   toports => 8080,
  }
  firewall { '102 forward port 80 to 8080 on eth1':
   table   => 'nat',
   chain   => 'PREROUTING',
   iniface => 'eth1',
   proto   => 'tcp',
   dport   => '80',
   jump    => 'REDIRECT',
   toports => 8080,
  }
  # set up the db
  include profiles::db_mysql
  mysql::db { 'asdb' :
    user     => $db_user,
    password => $db_passwd,
    dbname   => 'asdb',
    host     => 'localhost',
    grant    => [ 'ALL' ],
    notify   => Class['archivesspace'],
  }
  Class['profiles::db_mysql']->Class['archivesspace']

}
