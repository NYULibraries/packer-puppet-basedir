class roles::archivesspace_dev {
    include profiles::base
    require profiles::db_mysql
    include profiles::aspace_dev
}
