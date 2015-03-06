# == Class: lcmaps::params

class lcmaps::params {

    $conf_file               = '/etc/lcmaps.db'
    $enable_posix_enf        = true
    $gsi_authz_conf_file     = '/etc/grid-security/gsi-authz.conf'
    $gsi_authz_conf_manage   = true
    $gumsclient_cert         = '/etc/grid-security/hostcert.pem'
    $gumsclient_endpoint     = 'https://yourgums.yourdomain:8443/gums/services/GUMSXACMLAuthorizationServicePort'
    $gumsclient_key          = '/etc/grid-security/hostkey.pem'
    $gumsclient_resourcetype = 'ce'
    $package_name            = 'lcmaps'
    $package_ensure          = 'present'
    $package_plugins         = undef
    $package_plugins_ensure  = 'present'
    $sazclient_endpoint      = 'https://yoursaz.yourdomain:8443/saz/services/SAZXACMLAuthorizationServicePort'

}
