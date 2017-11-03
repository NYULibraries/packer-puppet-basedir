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
  include tct::uwsgi
  include tct::install::frontend
  include tct::nginx

  Class[tct::install]->
  Class[tct::install::backend]->
  Class[tct::uwsgi]->
  Class[tct::install::frontend]
  #Class[tct::nginx]

}
