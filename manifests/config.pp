# == Define: postfix::config
#
# Insert tidbits/fragments of configuration for postfix used throughout the
# module.
#
# === Parameters
#
# [*ensure*]
#   Should be either present or absent
#
# [*value*]
#   Value of the config
#
# [*order*]
#   Optional, determines the order of this configuration snippet relative to
#   others.
#
# === Examples
#
# TBD
#
# === Authors
#
# Proteon
#
# === Copyright
#
# Copyright 2013 Proteon
#
define postfix::config (
    $ensure = present,
    $value = '',
    $order = 10,
) {

    $config_file = '/etc/postfix/main.cf'

    concat::fragment {"postfix config ${name}":
        ensure  => $ensure,
        target  => $config_file,
        content => "${name} = ${value}\n",
        order   => $order
    }

}
