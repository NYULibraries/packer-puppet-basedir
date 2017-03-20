#
class housekeeping (
    $user = $housekeeping::params::user
) inherits housekeeping::params {

  if $facts['virtual'] != 'docker' {
    python::pip { 'awscli':
      ensure     => latest,
      pkgname    => 'awscli',
      virtualenv => 'system',
      owner      => 'root',
      timeout    => 1800,
    }
  }
  include housekeeping::packages
  #include housekeeping::python
  #include housekeeping::aws
  include housekeeping::ruby

  housekeeping::user{ 'root': }
  #housekeeping::user{ $user: }

  housekeeping::gemrc{ 'root': }
  #housekeeping::gemrc{ $user: }

}
