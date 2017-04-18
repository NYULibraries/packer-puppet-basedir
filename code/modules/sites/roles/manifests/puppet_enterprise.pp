class roles::puppet_enterprise {
  include profiles::base
  include profiles::cms_pe
  #include profiles::rbenv
}
