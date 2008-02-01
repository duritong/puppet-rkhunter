# modules/rkhunter/manifests/init.pp - manage rkhunter
# Copyright (C) 2007 admin@immerda.ch
# 

#modules_dir { "rkhunter": }

class rkhunter {

	package { 'rkhunter':
                ensure => present,
                category => $operatingsystem ? {
                        gentoo => 'app-forensics',
                        default => '',
                },
        }
}

define rkhunter::config($source)
    file {
        "/var/lib/rkhunter/rkhunter.db":
            source => "puppet://$servername/$source",
            ensure => file,
            force => true,
            mode => 0400, owner => root, group => root;
     }
}
