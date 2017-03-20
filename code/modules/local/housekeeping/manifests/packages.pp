#
class housekeeping::packages (
    $user = $housekeeping::params::user
) inherits housekeeping::params {

  ensure_packages([
    'bzip2-devel',
    'bind-utils',
    'epel-release',
    'gdbm-devel',
    'gcc',
    'gcc-c++',
    'git',
    'libffi-devel',
    'libxslt-devel',
    'libyaml-devel',
    'lsof',
    'ncurses-devel',
    'make',
    'openssl-devel',
    'patch',
    'readline-devel',
    'sqlite-devel',
    'zlib-devel',
    'unzip',
    'zip',
    'zlib-devel',
  ])

  ensure_packages([
    'r10k',
  ], {'provider' => 'gem'})
}
