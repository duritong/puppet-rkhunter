# manage basic installation
class rkhunter::base {
  package { 'rkhunter':
    ensure => present,
  } -> file{'/etc/rkhunter.conf.local': # all use specific changes can go in here
    ensure  => 'present',
    owner   => root,
    group   => 0,
    mode    => '0400';
  }

  case $::operatingsystem {
    debian: {
      case $::lsbdistcodename {
        'etch': { info('no need to init the database') }
        default: { include rkhunter::dbinit }
      }
    }
    default: { include rkhunter::dbinit }
  }

  file{'/usr/local/sbin/rkhunter_prelinker':
    source  => 'puppet:///modules/rkhunter/prelinker.rb',
    require => File['/etc/rkhunter.conf.local'],
    owner   => root,
    group   => 0,
    mode    => '0700';
  }
}
