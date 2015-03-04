# == Class: lcmaps::params

class lcmaps::params {

    $conf_file              = '/etc/lcmaps.db'
    $enable_posix_enf       = true
    $gsi_authz_conf_file    = '/etc/grid-security/gsi-authz.conf'
    $gsi_authz_conf_manage  = true
    $gums_endpoint          = 'https://yourgums.yourdomain:8443/gums/services/GUMSXACMLAuthorizationServicePort'
    $package_name           = 'lcmaps'
    $package_ensure         = 'present'
    $package_plugins        = undef
    $package_plugins_ensure = 'present'
    $saz_endpoint           = 'https://yoursaz.yourdomain:8443/saz/services/SAZXACMLAuthorizationServicePort'

}
