#
class housekeeping::bastion (
    $user = $housekeeping::params::user
) inherits housekeeping::params {

  ensure_packages([
    'epel-release',
    'gdbm-devel',
    'lsof',
    'ncurses-devel',
    'openssl-devel',
    'zlib-devel',
  ])

}
