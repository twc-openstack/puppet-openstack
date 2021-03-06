# == Class: openstack::auth_file
#
# Creates an auth file that can be used to export
# environment variables that can be used to authenticate
# against a keystone server.
#
# === Parameters
#
# [*admin_password*]
#   (required) Admin password
# [*controller_node*]
#   (optional) Keystone address. Defaults to '127.0.0.1'.
# [*keystone_admin_token*]
#   (optional) Admin token.
#   NOTE: This setting will trigger a warning from keystone.
#   Authentication credentials will be ignored by keystone client
#   in favor of token authentication. Defaults to undef.
# [*admin_user*]
#   (optional) Defaults to 'admin'.
# [*admin_tenant*]
#   (optional) Defaults to 'openstack'.
# [*region_name*]
#   (optional) Defaults to 'RegionOne'.
# [*use_no_cache*]
#   (optional) Do not use the auth token cache. Defaults to true.
# [*cinder_endpoint_type*]
#   (optional) Defaults to 'publicURL'.
# [*glance_endpoint_type*]
#   (optional) Defaults to 'publicURL'.
# [*keystone_endpoint_type*]
#   (optional) Defaults to 'publicURL'.
# [*nova_endpoint_type*]
#   (optional) Defaults to 'publicURL'.
# [*neutron_endpoint_type*]
#   (optional) Defaults to 'publicURL'.
# [*create_openrc*]
#   (optional) Whether the openrc file should be created. Defaults to
#   true. When false the file will be removed if it exists.
#
class openstack::auth_file(
  $admin_password,
  $controller_node          = '127.0.0.1',
  $keystone_admin_token     = undef,
  $admin_user               = 'admin',
  $admin_tenant             = 'openstack',
  $region_name              = 'RegionOne',
  $use_no_cache             = true,
  $cinder_endpoint_type     = 'publicURL',
  $glance_endpoint_type     = 'publicURL',
  $keystone_endpoint_type   = 'publicURL',
  $nova_endpoint_type       = 'publicURL',
  $neutron_endpoint_type    = 'publicURL',
  $create_openrc            = true,
) {

  if $create_openrc {
    file { '/root/openrc':
      owner   => 'root',
      group   => 'root',
      mode    => '0700',
      content => template("${module_name}/openrc.erb")
    }
  }
  else {
    file { '/root/openrc':
      ensure => absent,
    }
  }
}
