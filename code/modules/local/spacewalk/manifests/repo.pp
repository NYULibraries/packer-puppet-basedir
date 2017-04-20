# == Class: spacewalk::repo
#
#
# === Parameters
#
#
# === Authors
#
# Flannon Jackson <flannon@nyu.edu>
#
# === Copyright
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class spacewalk::repo {

  #http://yum.spacewalkproject.org/latest/RHEL/7/x86_64/

  yumrepo { 'spacewalk':
    ensure          => present,
    descr           => 'spacewalk',
    baseurl         => "http://yum.spacewalkproject.org/latest/RHEL/${operatingsystemmajrelease}/x86_64/",
    enabled         => 1,
    protect         => 0,
    gpgcheck        => 0,
    gpgkey          => 'http://yum.spacewalkproject.org/RPM-GPG-KEY-spacewalk-2015',
    metadata_expire => '30',
  }

  yumrepo { 'jpackage-generic':
    ensure   => present,
    descr    => 'jpackage-generic',
    baseurl  => 'http://mirrors.dotsrc.org/pub/jpackage/5.0/generic/free/',
    #mirrorlist=http://www.jpackage.org/mirrorlist.php?dist=generic&type=free&release=5.0,
    enabled  => 1,
    gpgcheck => 1,
    gpgkey   => 'http://www.jpackage.org/jpackage.asc',
  }

}
