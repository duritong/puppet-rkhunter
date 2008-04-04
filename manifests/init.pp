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

    file {
        "/etc/rkhunter.conf"
            source => [ "puppet://$servername/files/rkhunter/${fqdn}/rkhunter.config",
                        "puppet://$servername/files/rkhunter/rkhunter.config",
                        "puppet://$servername/rkhunter/rkhunter.config" ],
            ensure => file,
            force => true,
            mode => 0400, owner => root, group => root;
     }
}

class rkhunter::gentoo inherits rkhunter::base {
    Package[rkhunter]{
        category => 'app-forensics',
    }
}
