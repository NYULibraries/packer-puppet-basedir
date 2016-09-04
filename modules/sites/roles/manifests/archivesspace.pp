# == Class: role::arhcivesspace.pp
#
# Full description of class role here.
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
class roles::archivesspace {
  include profiles::base
  include profiles::archivesspace_profile
}
