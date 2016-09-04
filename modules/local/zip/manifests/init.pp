class zip {

    package { "zip":
      ensure => "installed",
    }

    package { "unzip":
      ensure => "installed",
    }

}
