# Class: tct::params
# ===========================
#
# Full description of class tct here.
#
#
# Examples
# --------
#
#
# Authors
# -------
#
# Flannon Jackson <flannon@nyu.edu>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class tct::params {

  case $::osfamily {
    'RedHat' : {
      $backend     = "dlts-enm-tct-backend"
      $frontend    = "dlts-enm-tct-frontend"
      $install_dir = "/opt/tct"
      $user        = 'tct'
      $venv        = '/opt/tct/virtualenv'
      $db_user     = 'tctdb'
      $db_password = 'cFHg*Liw45'
      $db_host     = 'localhost'
      $tct_db      = 'nyuotl_db'
      $secret_key  = 'some_long_random_string_of_letters_numbers_and_symbols'
      $baseurl     = 'http://tct.home.wfc/'
      $www_dir     = '/var/www/html'
    }
  }
}
