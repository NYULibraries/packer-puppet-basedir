class roles::docker::loris {
  include profiles::base_docker
  #include profiles::loris_docker_profile
  include profiles::img_loris
}
