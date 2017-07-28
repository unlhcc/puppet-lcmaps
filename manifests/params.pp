# == Class: lcmaps::params

class lcmaps::params {

    $conf_file                    = '/etc/lcmaps.db'
    $conf_file_template           = 'lcmaps/lcmaps.db.erb'
    $enable_posix_enf             = true
    $gsi_authz_conf_file          = '/etc/grid-security/gsi-authz.conf'
    $gsi_authz_conf_file_template = 'lcmaps/gsi-authz.conf.erb'
    $gsi_authz_conf_manage        = true
    $gumsclient_cert              = '/etc/grid-security/hostcert.pem'
    $gumsclient_endpoint          = 'https://yourgums.yourdomain:8443/gums/services/GUMSXACMLAuthorizationServicePort'
    $gumsclient_key               = '/etc/grid-security/hostkey.pem'
    $gumsclient_resourcetype      = 'ce'
    $package_name                 = 'lcmaps'
    $package_ensure               = 'present'
    $package_plugins              = undef
    $package_plugins_ensure       = 'present'

    $gridmapfile                  = '/etc/grid-security/grid-mapfile'
    $gridmapfile_template         = undef
    $vomsmapfile                  = '/etc/grid-security/voms-mapfile'
    $vomsmapfile_template         = undef
    $defaultmapfile               = '/usr/share/osg/voms-mapfile-default'
    $defaultmapfile_template      = undef
    $banfile                      = '/etc/grid-security/ban-mapfile'
    $banfile_template             = undef
    $banvomsfile                  = '/etc/grid-security/ban-voms-mapfile'
    $banvomsfile_template         = undef
    $sysconfig_ce_template        = undef
    $sysconfig_ce_file            = '/etc/sysconfig/condor-ce'

}
