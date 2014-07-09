# manage basic installation
class rkhunter::base {
  package { 'rkhunter':
    ensure => present,
  } -> file{'/etc/rkhunter.conf.local': # all use specific changes can go in here
    content => template('rkhunter/rkhunter.conf.local.erb'),
    owner   => root,
    group   => 0,
    mode    => '0400';
  }

  include rkhunter::dbinit
  file{'/usr/local/sbin/rkhunter_prelinker':
    source  => 'puppet:///modules/rkhunter/prelinker.rb',
    require => File['/etc/rkhunter.conf.local'],
    owner   => root,
    group   => 0,
    mode    => '0700';
  }
}
