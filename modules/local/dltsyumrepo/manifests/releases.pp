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
class dltsyumrepo::releases {

    file { 'dlts-releases.repo' :
      path   => '/etc/yum.repos.d/dlts-releases.repo',
      ensure => present,
      source => "puppet:///modules/dltsyumrepo/dlts-releases.repo",
    }
}
