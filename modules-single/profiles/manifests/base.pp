class profiles::base {

    # Processes all yumrepo types  before any packages that
    # don't have 'rpm' as their provider.  Allows epel rpm package
    # to help install the package.
    #  from http://bit.ly/1xrYz1t

    Yumrepo <| |> -> Package <| provider != 'rpm' |>

    #resources { 'firewall':
    #    purge => true,
    #}
    Firewall {
      before => Class['fw::post'],
      require => Class['fw::pre'],
    }   
    class { ['fw::pre', 'fw::post']: }
    class { 'firewall': }
    firewall {'001 allow inbound ssh':
      dport => 22,
      proto => tcp,
      action => accept,
      provider => 'iptables',
    }

    class { 'accounts':
      ssh_keys   => hiera_hash('accounts::ssh_keys', {}),
      users      => hiera_hash('accounts::users', {}),
      usergroups => hiera_hash('accounts::usergroups', {}),
      require    => Class['hiera'],
    }

    include epel
    class { 'hiera':
      hierarchy => [
        '%{environment}/%{calling_class}',
        '%{environment}',
        'accounts',
        'common',
      ],
    }
    include housekeeping
    class { 'localtime':
        zone => "America/New_York",
    }
    class { '::logrotate' :
      ensure            => 'latest',
      config            => {
        compress        => true,
        compresscmd     => '/usr/bin/bzip2',
        compressoptions => '-9',
        compressext     => '.bz2',
      }
    }
    #logrotate::conf { '/etc/logrotate.conf':
    #  rotate       => 4,
    #  rotate_every => 'week',
    #  ifempty      => true,
    #  compress     => true,
    #}
    logrotate::rule { 'messages':
      compress     => true,
      compresscmd  => '/usr/bin/bzip2',
      compressext  => '.bz2',
      path         => '/var/log/messages',
      rotate       => 4,
      rotate_every => 'daily',
      #postrotate  => '/usr/bin/killall -HUP syslogd'
      postrotate   => '/sbin/service rsyslog restart 2> /dev/null',
    }
    include manpages
    include motd
    class { '::ntp':
        servers  => [ 'tick.nyu.edu', 'tock.nyu.edu' ],
    }
    include s3cmd
    include stdlib
    #include vagrant
    include vim
    class { 'yum_autoupdate':
        #notify_email => false,
        email_to     => 'flannon@nyu.edu',
        email_from   => "yum@${hostname}",
    }
    include yumutils

}
