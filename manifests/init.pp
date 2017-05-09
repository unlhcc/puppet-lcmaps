# Class: lcmaps
#
# lcmaps module for use at Holland Computing Center
#
# Defaults match some combination of OSG packaging and what HCC uses
#
# Parameters:
#
# [*conf_file*]
#   Location of configuration file for lcmaps. Default: /etc/lcmaps.db
#
# [*conf_file_template*]
#   Template used to generate conf_file
#
# [*enable_posix_enf*]
#   Enables the posix_enf enforcement plugin. Default: true
#
# [*gsi_authz_conf_file*]
#   Location of gsi-authz.conf. Default: /etc/grid-security/gsi-authz.conf
#
# [*gsi_authz_conf_file_template*]
#   Template used to generate gsi_authz_conf_file
#
# [*gsi_authz_conf_manage*]
#   Whether to manage gsi-authz.conf. Default: true
#
# [*gumsclient_cert*]
#   Path to certificate with which host identifies itself when connecting
#   to the SCAS service. Setting to '' will remove it entirely.
#   Default: /etc/grid-security/hostcert.pem
#
# [*gumsclient_endpoint*]
#   Full URL to GUMS endpoint.
#   Default: https://yourgums.yourdomain:8443/gums/services/GUMSXACMLAuthorizationServicePort
#
# [*gumsclient_key*]
#   Path to certificate key with which host identifies itself when connecting
#   to the SCAS service. Setting to '' will remove it entirely.
#   Default: /etc/grid-security/hostkey.pem
#
# [*gumsclient_resourcetype*]
#   Resource type identifier. Must be one of rb, ce, se, wn.
#   Default: ce
#
# [*package_name*]
#   The name of the package to install. Default: lcmaps
#
# [*package_ensure*]
#   Ensure the package is present, latest, or absent. Default: present
#
# [*package_plugins*]
#   The name(s) of plugin packages to install. Default: <undefined>
#
# [*package_plugins_ensure*]
#   Ensure the packages defined in $package_plugins are present, latest, or absent.
#   Default: present
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class lcmaps (
    $conf_file                    = $lcmaps::params::conf_file,
    $conf_file_template           = $lcmaps::params::conf_file_template,
    $enable_posix_enf             = $lcmaps::params::enable_posix_enf,
    $gsi_authz_conf_file          = $lcmaps::params::gsi_authz_conf_file,
    $gsi_authz_conf_file_template = $lcmaps::params::gsi_authz_conf_file_template,
    $gsi_authz_conf_manage        = $lcmaps::params::gsi_authz_conf_manage,
    $gumsclient_cert              = $lcmaps::params::gumsclient_cert,
    $gumsclient_endpoint          = $lcmaps::params::gumsclient_endpoint,
    $gumsclient_key               = $lcmaps::params::gumsclient_key,
    $gumsclient_resourcetype      = $lcmaps::params::gumsclient_resourcetype,
    $package_name                 = $lcmaps::params::package_name,
    $package_ensure               = $lcmaps::params::package_ensure,
    $package_plugins              = $lcmaps::params::package_plugins,
    $package_plugins_ensure       = $lcmaps::params::package_plugins_ensure,
    ) inherits lcmaps::params {

    validate_absolute_path($conf_file)
    validate_string($conf_file_template)
    validate_bool($enable_posix_enf)
    validate_absolute_path($gsi_authz_conf_file)
    validate_string($gsi_authz_conf_file_template)
    validate_bool($gsi_authz_conf_manage)
    validate_string($gumsclient_cert)
    validate_string($gumsclient_endpoint)
    validate_string($gumsclient_key)
    validate_re($gumsclient_resourcetype, [ '^rb$', '^ce$', '^se$', '^wn$' ], 'Error: gumsclient_resourcetype must be one of rb, ce, se, wn')
    validate_string($package_name)
    validate_re($package_ensure, [ '^present', '^latest', '^absent' ], 'Error: package_ensure must be either present, latest, or absent')
    validate_re($package_plugins_ensure, [ '^present', '^latest', '^absent' ], 'Error: package_ensure must be either present, latest, or absent')

    package { $package_name:
        ensure => $package_ensure,
    }

    if $package_plugins {
        package { $package_plugins:
            ensure => $package_plugins_ensure,
        }
    }

    file { $conf_file:
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        require => Package[$package_name],
        content => template($conf_file_template),
    }

    if $gsi_authz_conf_manage {
        file { $gsi_authz_conf_file:
            ensure  => present,
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            content => template($gsi_authz_conf_file_template),
        }
    }

}
