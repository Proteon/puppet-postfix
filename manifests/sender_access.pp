# == Define: postfix::sender_access
#
# Define a set of addresses which should be allowed to send from/through this
# server.
#
# === Parameters
#
# [*file*]
#   Filename for the config.
#
# [*addresses*]
#   Addresses allowed to send from/through this server.
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
define postfix::sender_access (
    $file,
    $addresses
) {
    postfix::hash { "/etc/postfix/${file}":
        ensure  => present,
    }
    file { "/etc/postfix/${file}":
        ensure  => present,
        mode    => '0644',
        content => template('postfix/sender_access.erb'),
        notify  => Exec["generate /etc/postfix/${file}.db"],
        require => Package['postfix'],
    }
}
