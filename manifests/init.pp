# modules/rkhunter/manifests/init.pp - manage rkhunter
# Copyright (C) 2007 admin@immerda.ch
# 

modules_dir { "rkhunter": }

class rkhunter {

	package { 'rkhunter':
                ensure => present,
                category => $operatingsystem ? {
                        gentoo => 'app-forensics',
                        default => '',
                },
        }


	#service { rkhunter: ensure  => running, enable  => true, }

#	file {
#        	"/etc/rkhunter/rkhunter.conf":
#                	source => "puppet://$servername/rkhunter/rkhunter.conf",
#        		ensure => file,
#        		force => true,
#        		mode => 0644, owner => root, group => root;
#        }
	
}

