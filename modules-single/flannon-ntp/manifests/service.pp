class ntp::service inherits ntp {

    if ! ($service_ensure in [ 'running', 'stopped' ]) {
        fail('service_ensure parameter mus be runningor stopped')
    }

    if $service_manage == true {
        service { 'ntp':
          ensure     => $service_ensure,
          enable     => $service_enable,
          name       => $service_name,
          hasstatus  => true,
          hasrestart => true,
        }
    }

}
