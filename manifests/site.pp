
# Apply rpm packages first
Yumrepo <| |> -> Package <| provider != 'rpm' |> 


node /jenkins/ {

  include roles::jenkins

}

node default {

  include profiles::base

}
