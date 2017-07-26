# manage basic installation
class rkhunter::base {
  package { 'rkhunter':
    ensure => installed,
  }
  # all user specific changes can go here
  concat{'/etc/rkhunter.conf.local':
    owner   => 'root',
    group   => 0,
    mode    => '0400',
    require => Package['rkhunter'],
  }
  concat::fragment{'module_default':
    target  => '/etc/rkhunter.conf.local',
    content => template('rkhunter/rkhunter.conf.local.erb'),
    order   => '05',
  }

  include ::rkhunter::dbinit
  ensure_packages('prelink')
  file{'/usr/local/sbin/rkhunter_prelinker':
    source  => 'puppet:///modules/rkhunter/prelinker.rb',
    require => [Concat['/etc/rkhunter.conf.local'], Package['prelink']],
    owner   => 'root',
    group   => 0,
    mode    => '0700';
  }
}
