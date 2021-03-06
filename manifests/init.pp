# == Class: postfix
#
# This module does basic installation and configuration of the postfix package.
# For servers which explicitly don't need postfix it can be removed with the
# 'absent' value as the 'ensure' parameter.
#
# === Parameters
#
# [*ensure*]
#   Either present or absent
#
# [*additional_mydestinations*]
#   Additional hostnames which will be added to the mydestinations setting of
#   postfix.
#
# === Variables
#
# N/A
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
class postfix (
    $ensure = 'present',
    $myhostname = $fqdn,
    $myorigin = $fqdn,
    $additional_mydestinations = [],
    $inet_protocols = 'all',  # set to 'ipv4' tp disable 'ipv6'
) {
    include postfix::aliases
    include postfix::params

    $postfix_smtp_listen = $postfix::params::postfix_smtp_listen
    $postfix_mail_user = $postfix::params::postfix_mail_user
    $tls_security_level = $postfix::params::tls_security_level

    package { 'postfix':
        ensure  => $ensure,
    }

    if ($ensure == 'present') {
        service { 'postfix':
            ensure    => running,
            enable    => true,
            hasstatus => true,
            restart   => '/etc/init.d/postfix restart',
            require   => Package['postfix'],
        }

        file { '/etc/mailname':
            ensure  => present,
            content => "${::fqdn}\n",
        }

        file { '/etc/postfix/master.cf':
            ensure  => present,
            mode    => '0644',
            content => template('postfix/master.cf.erb'),
            notify  => Service['postfix'],
            require => Package['postfix'],
        }

        concat { '/etc/postfix/main.cf':
            owner   => root,
            group   => root,
            mode    => '0644',
            notify  => Service['postfix'],
            require => Package['postfix'],
        }

        concat::fragment {'/etc/postfix/main.cf base config':
            target  => '/etc/postfix/main.cf',
            content => template('postfix/main.cf.erb'),
            order   => 0
        }

        postfix::config {
            'myorigin':
                value   => $myorigin;
            'alias_maps':
                value   => 'hash:/etc/aliases';
            'inet_interfaces':
                value   => 'all';
            'inet_protocols':
                value  => $inet_protocols;
        }
    }
}
