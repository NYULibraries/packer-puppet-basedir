class ntp::config inherits ntp {

    if $keys_enable {
        $directory = dirname($keys_file)
        file { $directory:
          ensure => direcotry,
          owner => 0,
          group => 0,
          mode  => '0755',
          recurse => true,
        }
    }

    file { $config:
      ensure  => file,
      owner   => 0,
      group   => 0,
      mode    => '0644',
      content => template($config_template),
    }
}
