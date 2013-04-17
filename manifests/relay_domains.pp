# == Define: postfix::relay_domains
#
# Used to define a set of domains which this installation of postfix will be
# allowed to forward mail for.
#
# === Parameters
#
# [*file*]
#   Filename for the config.
#
# [*domains*]
#   List of domains which will be allowed to forward mail.
#
# === Examples
#
# TDB
#
# === Authors
#
# Proteon
#
# === Copyright
#
# Copyright 2013
#
define postfix::relay_domains (
    $file,      # Filename relative to /etc/postfix/
    $domains    # List of hashes of domains and relay status
                # (generally $domain => 'OK')
) {
    postfix::hash { "/etc/postfix/${file}":
        ensure  => present,
    }

    postfix::config { 'relay_domains':
        value   => "hash:/etc/postfix/${file}",
        require => Postfix::Hash["/etc/postfix/${file}"],
    }

    file { "/etc/postfix/${file}":
        ensure  => present,
        mode    => '0644',
        content => template('postfix/relay_domains.erb'),
        notify  => Exec["generate /etc/postfix/${file}.db"],
        require => Package['postfix'],
    }
}
