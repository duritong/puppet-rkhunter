class rkhunter::centos inherits rkhunter::base {
  file{'/etc/sysconfig/rkhunter':
    source => [ "puppet://$server/files/rkhunter/sysconfig/${fqdn}/rkhunter",
                "puppet://$server/files/rkhunter/sysconfig/rkhunter",
                "puppet://$server/rkhunter/sysconfig/rkhunter" ],
    require => Package['rkhunter'],
    mode => 0644, owner => root, group => root;
  }
}
