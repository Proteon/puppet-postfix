# == Define: virtual_alias_maps
#
# Postfix's vhost analog
#
# === Parameters
#
# Document parameters here
#
# [*file*]
#   Filename for the config.
#
# [*addresses*]
#   List of addresses to map
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
# TODO: fix documentation
define postfix::virtual_alias_maps (
    $file,
    $addresses
) {
    postfix::hash { "/etc/postfix/${file}":
        ensure  => present,
    }

    postfix::config { 'virtual_alias_maps':
        value   => "hash:/etc/postfix/${file}",
        require => Postfix::Hash["/etc/postfix/${file}"],
    }

    file { "/etc/postfix/${file}":
        ensure  => present,
        mode    => '0644',
        content => template('postfix/virtual_alias_maps.erb'),
        notify  => Exec["generate /etc/postfix/${file}.db"],
        require => Package['postfix'],
    }
}
