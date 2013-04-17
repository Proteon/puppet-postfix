# Class: postfix::params
#
# This module manages Postfix paramaters
#
# Parameters:
#
# There are no default parameters for this class.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class postfix::params {
    $alias_map =  {
        'mailer-daemon'    => 'postmaster',
        'admin'            => 'root',
        'postmaster'       => 'root',
        'nobody'           => 'root',
        'hostmaster'       => 'root',
        'webmaster'        => 'root',
        'www'              => 'root',
        'ftp'              => 'root',
        'abuse'            => 'root',
        'noc'              => 'root',
        'security'         => 'root',
    }
    $postfix_smtp_listen = '0.0.0.0'
    $postfix_mail_user = 'vmail'
}
