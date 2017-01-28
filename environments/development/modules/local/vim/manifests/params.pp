class vim::params {

  case $facts['osfamily'] {
    'RedHat': {
      case $facts['os']['release']['major'] {
        '7': {
          if $facts['virtual'] == 'virtualbox' {
            $user = 'vagrant'
          }
          elsif $facts['xenu'] == 'xenu' {
            $user = 'centos'
          }
        }
        default: {
          fail( "${facts['os']} $facts{['os']['release']['major']} is not supported at this time" )
        }
      }
    }
    default: {
      fail( "${facts['osfamily']} not supported at this time" )
    }
  }
}
