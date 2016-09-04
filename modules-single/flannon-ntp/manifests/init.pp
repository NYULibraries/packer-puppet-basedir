class ntp {
    case $operatingsystem {
        centos, redhat: {
            $service_name = 'ntpd'
            $conf_file    = 'ntp.conf.el'
        }
        debian, ubuntu: {
            $service_name = 'ntp'
            $conf_file    = 'ntp.conf.debian'
        }
    }

    package { 'ntp':
     #require => notify {"Package: ntp installed": }
     #notify {"Package: ntp installed": }
     #ensure => 'present',
     ensure => installed,
    }
    file { '/etc/ntp.conf':
      path   => '/etc/ntp.conf',
      ensure => file,
      owner  => root,
      group  => root,
      mode   => 0644,
      require => Package['ntp'],
      source => 'puppet:///modules/ntp/ntp.conf',
      #notify => Service['ntp'],
      #content  => templae('ntp/ntp.conf.erb'),
      #require => Package[$package],
    } 
    service { 'ntpd':
      ensure => 'running',
      enable => true,
      subscribe => File['ntp.conf'],
    }

}


