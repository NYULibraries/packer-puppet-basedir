# == Class: spacewalk::install
#
# === Authors
#
# Flannon Jackson <flannon@nyu.edu>
#
# === Copyright
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class spacewalk::install {

  package { 'spacewalk-setup-postgresql':
    ensure => installed,
  }

  package { 'spacewalk-setup':
    ensure => installed,
  }

  firewall { '100 open spacewalk service ports':
    dport  => [62, 80, 443, 5222 ],
    proto  => tcp,
    action => accept,
  }
}
