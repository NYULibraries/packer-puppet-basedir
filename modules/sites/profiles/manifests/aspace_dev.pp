class profiles::aspace_dev {
  $install_dir = hiera('archivesspace_dev::install_dir')
  $revision    = hiera('archivesspace_dev::revision')
  $source      = hiera('archivesspace_dev::source')
  $user        = hiera('archivesspace_dev::user')

  firewall { '100 allow http and https access':
      dport   => [3000, 3100, 4567, 8080, 8081,  8089, 8090, 8091 ],
      proto   => tcp,
      action  => accept,
  }
  include housekeeping
  include java
  class { 'archivesspace_dev' :
      install_dir => $install_dir,
      revision    => $revision,
      source      => $source,
      user        => $user,
  }

  mysql::db { 'asdb' :
    user     => 'asdb',
    password => 'letmein',
    dbname   => 'asdb',
    host     => 'localhost',
    grant    => [ 'ALL' ],
  }


}
