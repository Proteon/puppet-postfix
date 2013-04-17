# == Define: postfix::transport_maps
#
# Define an address mapping table for postfix.
#
# === Parameters
#
# Document parameters here
#
# [*file*]
#   Filename for the config.
#
# [*domains*]
#   List of domains to map
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
define postfix::transport_maps (
    $file,
    $domains
) {
    postfix::hash { "/etc/postfix/${file}":
        ensure  => present,
    }

    postfix::config { 'transport_maps':
        value   => "hash:/etc/postfix/${file}",
        require => Postfix::Hash["/etc/postfix/${file}"],
    }

    file { "/etc/postfix/${file}":
        ensure  => present,
        mode    => '0644',
        content => template('postfix/transport_maps.erb'),
        notify  => Exec["generate /etc/postfix/${file}.db"],
        require => Package['postfix'],
    }
}
