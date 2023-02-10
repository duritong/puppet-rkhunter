# manage centos
class rkhunter::centos inherits rkhunter::base {
  file_line{'rkhunter_mail_root':
    path    => '/etc/sysconfig/rkhunter',
    line    => 'MAILTO=root',
    match   => '^MAILTO=',
    require => Package['rkhunter'],
  }
  if versioncmp($facts['os']['release']['major'],'7') < 0 {
    concat::fragment{'HASH_CMD':
      target  => '/etc/rkhunter.conf.local',
      content => 'HASH_CMD=sha1sum',
    }
  }
  if versioncmp($facts['os']['release']['major'],'8') >= 0 {
    require yum::centos::dnf_post_transaction
    file {
      default:
        owner => root,
        group => 0;
      '/etc/dnf/plugins/post-transaction-actions.d/rkhunter.action':
        source => 'puppet:///modules/rkhunter/dnf/rkhunter.action',
        mode   => '0644';
      '/etc/cron.daily/0rkhunter':
        source => 'puppet:///modules/rkhunter/dnf/0rkhunter.cron',
        mode   => '0755';
    }
  }
}
