# == Class: spacewalk
#
# === Authors
#
# Flannon Jackson <flannon@nyu.edu>
#
# === Copyright
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class spacewalk {

  include spacewalk::repo
  include spacewalk::install

  Class[Spacewalk::Repo]->
  Class[Spacewalk::Install]
}
