class profiles::ichabod {

  #include imagemagick
  #include ffmpeg
  #include profile::tomcat6
  #  The firewall rule is taken care of in profile::tomcat6
  #  when it's enabled
  firewall { '100 allow 8080 for tomcat':
      port      => 8080,
      proto     => tcp,
      action    => accept,
    }


}
