# Class: tct
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
class tct {
  alert('Beginning install of the refreshed tct-2')
  include tct::install
  include tct::install::backend
  include tct::install::nginx
  include tct::install::frontend
}
