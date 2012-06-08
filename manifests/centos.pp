class rkhunter::centos inherits rkhunter::base {
  file{'/etc/sysconfig/rkhunter':
    source => [ "puppet:///modules/site_rkhunter/sysconfig/${::fqdn}/rkhunter",
                "puppet:///modules/site_rkhunter/sysconfig/rkhunter",
                "puppet:///modules/rkhunter/sysconfig/rkhunter" ],
    require => Package['rkhunter'],
    mode => 0644, owner => root, group => root;
  }
}
