#
define housekeeping::gemrc {
  if $title == 'root' {
    $home_dir = '/root'
  }
  else {
    $home_dir = "/home/${title}"
  }
  $user = $title

  file_line { "${title} no-doc":
    path => "${home_dir}/.gemrc",
    line => 'gem: --no-document',
  }
  file_line { "${title} no-rdoc":
    path => "${home_dir}/.gemrc",
    line => 'gem: --no-rdoc --no-ri',
  }

}
