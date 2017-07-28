# LCMAPS module for puppet

lcmaps module used by HCC with defaults following OSG release packaging.

# Parameters
conf_file
------------------
Location of the main lcmaps.db config file.
- *Default*: /etc/lcmaps.db

conf_file_template
------------------
Template used to generate conf_file.
- *Default*: lcmaps/lcmaps.db.erb

enable_posix_enf
------------------
Enables the posix_enf enforcement plugin.
- *Default*: true

gsi_authz_conf_file
------------------
Location of gsi-authz.conf.
- *Default*: /etc/grid-security/gsi-authz.conf

gsi_authz_conf_file_template
------------------
Template used to generate gsi_authz_conf_file
- *Default*: lcmaps/gsi-authz.conf.erb

gsi_authz_conf_manage
------------------
Whether to manage gsi-authz.conf.
- *Default*: true

gumsclient_cert
------------------
Path to certificate with which host identifies itself when connecting
to the SCAS service. Setting to '' will remove it entirely.
- *Default*: /etc/grid-security/hostcert.pem

gumsclient_endpoint
------------------
Full URL to GUMS endpoint.
- *Default*: https://yourgums.yourdomain:8443/gums/services/GUMSXACMLAuthorizationServicePort

gumsclient_key
------------------
Path to certificate key with which host identifies itself when connecting
to the SCAS service. Setting to '' will remove it entirely.
- *Default*: /etc/grid-security/hostkey.pem

gumsclient_resourcetype
------------------
Resource type identifier. Must be one of rb, ce, se, wn.
- *Default*: ce

package_name
------------------
The name of the package to install.
- *Default*: lcmaps

package_ensure
------------------
Ensure the package is present, latest, or absent.
- *Default*: present

package_plugins
------------------
The name(s) of plugin packages to install.
- *Default*: undef

package_plugins_ensure
------------------
Ensure the packages defined in $package_plugins are present, latest, or absent.
Only effective if package_plugins is defined.
- *Default*: present

gridmapfile
------------------
Location of the gridmapfile config.
- *Default*: /etc/grid-security/grid-mapfile

gridmapfile_template
------------------
Template used to generate gridmapfile. If undef puppet will not maintain file.
- *Default*: undef

vomsmapfile
------------------
Location of the vomsmapfile config.
- *Default*: /etc/grid-security/voms-mapfile

vomsmapfile_template
------------------
Template used to generate vomsmapfile. If undef puppet will not maintain file.
- *Default*: undef

defaultmapfile
------------------
Location of the defaultmapfile config.
- *Default*: /usr/share/osg/voms-mapfile-default

defaultmapfile_template
------------------
Template used to generate defaultmapfile. If undef puppet will not maintain file.
- *Default*: undef

banfile
------------------
Location of the banfile config.
- *Default*: /etc/grid-security/ban-mapfile

banfile_template
------------------
Template used to generate banfile. If undef puppet will not maintain file.
- *Default*: undef

banvomsfile
------------------
Location of the banvomsfile config.
- *Default*: /etc/grid-security/ban-voms-mapfile

banvomsfile_template
------------------
Template used to generate banvomsfile. If undef puppet will not maintain file.
- *Default*: undef

sysconfig_ce_template
------------------
Template used to generate sysconfig. If undef puppet will not maintain file.
- *Default*: undef

sysconfig_ce_file            
------------------
Location to put sysconfig, useful for setting 
LLGT_VOMS_ENABLE_CREDENTIAL_CHECK=1
-  *Default*: /etc/sysconfig/condor-ce 
