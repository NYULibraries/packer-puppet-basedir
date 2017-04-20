# == Class: spacewalk::params
#
# === Authors
#
# Flannon Jackson <flannon@nyu.edu>
#
# === Copyright
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class spacewalk::params {

  $admin_email = root@localhost
  $ssl_set_org = Spacewalk Org
  $ssl_set_org_unit = spacewalk
  $ssl_set_city = My City
  $ssl_set_state = My State
  $ssl_set_country = US
  $ssl_password = spacewalk
  $ssl_set_email = root@localhost
  $ssl_config_sslvhost = Y
  $db_backend=postgresql
  $db_name=spaceschema
  $db_user=spaceuser
  $db_password=spacepw
  $db_host=localhost
  $db_port=5432
  $enable_tftp=Y

}
