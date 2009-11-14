class rkhunter::centos inherits rkhunter::base {
  file{'/etc/sysconfig/rkhunter':
    source => [ "puppet://$server/modules/site-rkhunter/sysconfig/${fqdn}/rkhunter",
                "puppet://$server/modules/site-rkhunter/sysconfig/rkhunter",
                "puppet://$server/modules/rkhunter/sysconfig/rkhunter" ],
    require => Package['rkhunter'],
    mode => 0644, owner => root, group => root;
  }
}
