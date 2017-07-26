# manage centos
class rkhunter::centos inherits rkhunter::base {
  file_line{'rkhunter_mail_root':
    path    => '/etc/sysconfig/rkhunter',
    line    => 'MAILTO=root',
    match   => '^MAILTO=',
    require => Package['rkhunter'],
  }
  if versioncmp($::operatingsystemmajrelease,'7') < 0 {
    concat::fragment{'HASH_CMD':
      target  => '/etc/rkhunter.conf.local',
      content => 'HASH_CMD=sha1sum',
    }
  }
}
