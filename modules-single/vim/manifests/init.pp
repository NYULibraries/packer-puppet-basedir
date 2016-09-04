class vim {
  package { 'vim-enhanced':
    ensure => 'installed',
  }
  # install vimrc
  file { "/root/.vimrc":
    ensure  => file,
    source  => "puppet:///modules/vim/vimrc",
    owner   => 'root',
    group   => 'root',
  }

  # make directory for vim setup
  file { "/root/.vim":
    ensure  => directory,
    owner  => 'root',
    group  => 'root',
  } 
  
  file { "/home/ec2-user/.vimrc":
    ensure  => file,
    source  => "puppet:///modules/vim/vimrc",
    owner   => 'ec2-user',
    group   => 'ec2-user',
  }

  # make directory for vim setup
  file { "/home/ec2-user/.vim":
    ensure  => directory,
    owner  => 'ec2-user',
    group  => 'ec2-user',
  } 
  
  file {'/tmp/vim-setup.tar.gz':
    mode   => '0755',
    ensure => present,
    source => "puppet:///modules/vim/vim-setup.tar.gz",
    notify => Exec['unpack vim-setup'],
  }
  
  exec {'unpack vim-setup':
    command  	=> '/bin/tar zxf /tmp/vim-setup.tar.gz',
    cwd      	=> '/tmp',
    refreshonly => true,
    notify      => Exec['install vim-setup-root', 'install vim-setup-ec2-user'],
  }

  exec {'install vim-setup-root':
    cwd         => '/tmp/vim-setup/',
    command     => '/bin/cp -r * /root/.vim',
    logoutput   => true,
    refreshonly => true,
    require     => File['/root/.vim'],
    #notify      => Exec['cleanup vim-setup']
  }

  exec {'install vim-setup-ec2-user':
    cwd         => '/tmp/vim-setup/',
    command     => '/bin/cp -r * /home/ec2-user/.vim',
    logoutput   => true,
    refreshonly => true,
    require     => File['/home/ec2-user/.vim'],
    #notify     => Exec['cleanup vim-setup'],
  }

  #exec {'cleanup vim-setup':
  #  command => '/bin/rm -rf /tmp/vim-setup',
  #  cwd     => '/tmp',
  #  refreshonly => true,
  #}
}
