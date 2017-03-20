class housekeeping::ruby (
      $user = $loris::params::user
) inherits loris::params {

  class { 'ruby':
    gems_version => 'latest',
  }
  include ruby::dev
  class { 'ruby::gemrc' :
    gem_command => {
      'gem'     => [ 'no-document' ],
    }
  }

}
