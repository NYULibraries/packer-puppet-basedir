# == Class: roles::mysql
#
# Full description of class role here.
#
# === Parameters
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class roles::mysql {
    include profiles::base
    include profiles::db_mysql
}
