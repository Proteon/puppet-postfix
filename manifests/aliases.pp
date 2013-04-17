# == Class: postfix::aliases
#
# Set some (default) aliases for postfix
#
# === Parameters
#
# N/A
#
# === Variables
#
# N/A
#
# === Examples
#
# N/A, this class currently only meant for internal usage.
#
# === Authors
#
# Proteon
#
# === Copyright
#
# Copyright 2013 Proteon
#
# TODO: it would be more elegant to have a 'define postfix::alias' instead of this setup
class postfix::aliases (
    $alias_map = $postfix::params::alias_map
) inherits postfix::params {
    
    # Warning, this symlink construction is not universally the same among several Debian distrubutions
    file { '/etc/aliases':
        ensure  => '/etc/postfix/aliases',
    }

    file { '/etc/postfix/aliases':
        ensure  => file,
        mode    => '0644',
        content => template('postfix/aliases.erb'),
        notify  => Exec['newaliases'],
    }

    exec { 'newaliases':
        command     => '/usr/bin/newaliases',
        refreshonly => true,
        require     => Package['postfix'],
        subscribe   => File['/etc/aliases'],
    }
}
