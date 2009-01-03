# modules/rkhunter/manifests/init.pp - manage rkhunter
# Copyright (C) 2007 admin@immerda.ch
# 

#modules_dir { "rkhunter": }

class rkhunter {
    case $operatingsystem {
        gentoo: { include rkhunter::gentoo }
        default: { include rkhunter::base }
    }

}

class rkhunter::base {
	package { 'rkhunter':
        ensure => present,
    }

    file {"/etc/rkhunter.conf":
            source => [ "puppet://$server/files/rkhunter/${fqdn}/rkhunter.config",
                        "puppet://$server/files/rkhunter/${operatingsystem}/rkhunter.config",
                        "puppet://$server/files/rkhunter/rkhunter.config",
                        "puppet://$server/rkhunter/${operatingsystem}/rkhunter.config",
                        "puppet://$server/rkhunter/rkhunter.config" ],
	        require => Package['rkhunter'],
            mode => 0400, owner => root, group => root;
     }

    exec{'init_rkunter_db':
        command => 'rkhunter --propupd'
        creates => '/var/lib/rkhunter/db/rkhunter.dat',
    }
}

class rkhunter::gentoo inherits rkhunter::base {
    Package[rkhunter]{
        category => 'app-forensics',
    }
}
