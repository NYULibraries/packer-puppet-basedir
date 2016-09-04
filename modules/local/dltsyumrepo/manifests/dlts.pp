# Class: dltsyumrepo
# ===========================
#
# Full description of class dltsdevrepo here.
#
#
# Authors
# -------
#
# Author Name flannon@nyu.edu
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class dltsyumrepo::dlts {

    file { 'dlts.repo' :
      path   => '/etc/yum.repos.d/dlts.repo',
      ensure => present,
      source => "puppet:///modules/dltsyumrepo/dlts.repo",
    }
}
