# modules/rkhunter/manifests/init.pp - manage rkhunter
# Copyright (C) 2007 admin@immerda.ch
# 

class rkhunter {
    case $operatingsystem {
        gentoo: { include rkhunter::gentoo }
        centos: { include rkhunter::centos }
        default: { include rkhunter::base }
    }

}

class rkhunter::base {
	package { 'rkhunter':
        ensure => present,
    }

    file {"/etc/rkhunter.conf":
        source => [ "puppet://$server/files/rkhunter/${fqdn}/rkhunter.conf",
                    "puppet://$server/files/rkhunter/${operatingsystem}/${lsbdistcodename}/rkhunter.conf",
                    "puppet://$server/files/rkhunter/${operatingsystem}/rkhunter.conf",
                    "puppet://$server/files/rkhunter/rkhunter.conf",
                    "puppet://$server/rkhunter/${operatingsystem}/${lsbdistcodename}/rkhunter.conf",
                    "puppet://$server/rkhunter/${operatingsystem}/rkhunter.conf",
                    "puppet://$server/rkhunter/rkhunter.conf" ],
        require => Package['rkhunter'],
        mode => 0400, owner => root, group => root;
    }
    case $operatingsystem {
        debian: {
            case $lsbdistcodename {
                'etch': { info("no need to init the database") }
                default: { include rkhunter::dbinit }
            }
        }
        default: { include rkhunter::dbinit }
    }
}

class rkhunter::centos inherits rkhunter::base {
    file{'/etc/sysconfig/rkhunter':
        source => [ "puppet://$server/files/rkhunter/sysconfig/${fqdn}/rkhunter",
                    "puppet://$server/files/rkhunter/sysconfig/rkhunter",
                    "puppet://$server/rkhunter/sysconfig/rkhunter" ],
        require => Package['rkhunter'],
        mode => 0644, owner => root, group => root;
    }
}

class rkhunter::gentoo inherits rkhunter::base {
    Package[rkhunter]{
        category => 'app-forensics',
    }
}
