# == Define: postfix::hash
#
# Given a predefined existing file containing the actual hash at "${name}"
# generate a compiled version of the hash as "${name}.db"
#
# === Parameters
#
# [*ensure*]
#   Should be either present or absent
#
# [*source*]
#   Currently ignored
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
define postfix::hash (
    $ensure = 'present',
    $source = false
) {
    file {"${name}.db":
        ensure  => $ensure,
        mode    => '0600',
        require => Exec["generate ${name}.db"],
    }

    exec {"generate ${name}.db":
        command     => "postmap ${name}",
        refreshonly => true,
        require     => Package['postfix'],
    }
}
