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
#   The name(s) of plugin packages to install. Default: undef
#
# [*package_plugins_ensure*]
#   Ensure the packages defined in $package_plugins are present, latest, or absent.
#   Default: present
#
# [*gridmapfile*]
#   Location of the gridmapfile config
#
# [*gridmapfile_template*]
#   Template used to generate gridmapfile.
#   Default: undef, which prevents puppet from maintaining the file
#
# [*vomsmapfile*]
#   Location of the vomsmapfile config
#
# [*vomsmapfile_template*]
#   Template used to generate vomsmapfile.
#   Default: undef, which prevents puppet from maintaining the file
#
# [*defaultmapfile*]
#   Location of the defaultmapfile config
#
# [*defaultmapfile_template*]
#   Template used to generate defaultmapfile.
#   Default: undef, which prevents puppet from maintaining the file
#
# [*banfile*]
#   Location of the banfile config
#
# [*banfile_template*]
#   Template used to generate banfile.
#   Default: undef, which prevents puppet from maintaining the file
#
# [*banvomsfile*]
#   Location of the banvomsfile config
#
# [*banvomsfile_template*]
#   Template used to generate banvomsfile.
#   Default: undef, which prevents puppet from maintaining the file
# [*no_gums*] 
#    Specify is using lcmaps+voms and modify sysconfig
#    Default: False
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

    $gridmapfile                  = $lcmaps::params::gridmapfile,
    $gridmapfile_template         = $lcmaps::params::gridmapfile_template,
    $vomsmapfile                  = $lcmaps::params::vomsmapfile,
    $vomsmapfile_template         = $lcmaps::params::vomsmapfile_template,
    $defaultmapfile               = $lcmaps::params::defaultmapfile,
    $defaultmapfile_template      = $lcmaps::params::defaultmapfile_template,
    $banfile                      = $lcmaps::params::banfile,
    $banfile_template             = $lcmaps::params::banfile_template,
    $banvomsfile                  = $lcmaps::params::banvomsfile,
    $banvomsfile_template         = $lcmaps::params::banvomsfile_template,
    $no_gums			  = $lcmaps::params::no_gums,
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
    validate_absolute_path($gridmapfile)
    validate_absolute_path($vomsmapfile)
    validate_absolute_path($defaultmapfile)
    validate_absolute_path($banfile)
    validate_absolute_path($banvomsfile)
    validate_bool($no_gums)

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

    if $gridmapfile_template {
        file { $gridmapfile:
            ensure  => present,
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            require => Package[$package_name],
            content => template($gridmapfile_template),
        }
    }

    if $vomsmapfile_template {
        file { $vomsmapfile:
            ensure  => present,
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            require => Package[$package_name],
            content => template($vomsmapfile_template),
        }
    }

    if $defaultmapfile_template {
        file { $defaultmapfile:
            ensure  => present,
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            require => Package[$package_name],
            content => template($defaultmapfile_template),
        }
    }

    if $banfile_template {
        file { $banfile:
            ensure  => present,
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            require => Package[$package_name],
            content => template($banfile_template),
        }
    }

    if $banvomsfile_template {
        file { $banvomsfile:
            ensure  => present,
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            require => Package[$package_name],
            content => template($banvomsfile_template),
        }
    }
    if ($no_gums) and ($gumsclient_resourcetype == 'ce') {
	file { '/etc/syconfig/condor-ce':
	  ensure => present,
	}->
	file_line { 'Append lcmaps config line':
  	path => '/etc/sysconfig/condor-ce',  
  	line => 'LLGT_VOMS_ENABLE_CREDENTIAL_CHECK=1',
	}
    }
}
