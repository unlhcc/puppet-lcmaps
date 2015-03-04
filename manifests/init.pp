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
# [*enable_posix_enf*]
#   Enables the posix_enf enforcement plugin. Default: true
#
# [*gsi_authz_conf_file*]
#   Location of gsi-authz.conf. Default: /etc/grid-security/gsi-authz.conf
#
# [*gsi_authz_conf_manage*]
#   Whether to manage gsi-authz.conf. Default: true
#
# [*gums_endpoint*]
#   Full URL to GUMS endpoint.
#   Default: https://yourgums.yourdomain:8443/gums/services/GUMSXACMLAuthorizationServicePort
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
# [*saz_endpoint*]
#   Full URL to SAZ endpoint.
#   Default: https://yoursaz.yourdomain:8443/saz/services/SAZXACMLAuthorizationServicePort
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class lcmaps (
    $conf_file              = $lcmaps::params::conf_file,
    $enable_posix_enf       = $lcmaps::params::enable_posix_enf,
    $gsi_authz_conf_file    = $lcmaps::params::gsi_authz_conf_file,
    $gsi_authz_conf_manage  = $lcmaps::params::gsi_authz_conf_manage,
    $gums_endpoint          = $lcmaps::params::gums_endpoint,
    $package_name           = $lcmaps::params::package_name,
    $package_ensure         = $lcmaps::params::package_ensure,
    $package_plugins        = $lcmaps::params::package_plugins,
    $package_plugins_ensure = $lcmaps::params::package_plugins_ensure,
    $saz_endpoint           = $lcmaps::params::saz_endpoint,
    ) inherits lcmaps::params {

    validate_absolute_path($conf_file)
    validate_bool($enable_posix_enf)
    validate_absolute_path($gsi_authz_conf_file)
    validate_bool($gsi_authz_conf_manage)
    validate_string($gums_endpoint)
    validate_string($package_name)
    validate_re($package_ensure, [ '^present', '^latest', '^absent' ], 'Error: package_ensure must be either present, latest, or absent')
    validate_re($package_plugins_ensure, [ '^present', '^latest', '^absent' ], 'Error: package_ensure must be either present, latest, or absent')
    validate_string($saz_endpoint)

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
        content => template('lcmaps/lcmaps.db.erb'),
    }

    if $gsi_authz_conf_manage {
        file { $gsi_authz_conf_file:
            ensure  => present,
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            content => template('lcmaps/gsi-authz.conf.erb'),
        }
    }

}