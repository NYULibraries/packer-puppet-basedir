class roles::uqbar {
    include profiles::base
    include housekeeping::rbenv
    include profiles::vnebr
    include profiles::build-environment
}
