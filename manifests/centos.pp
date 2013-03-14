# manage centos
class rkhunter::centos inherits rkhunter::base {
  file_lin{'rkhunter_mail_root':
    path    => '/etc/sysconfig/rkhunter',
    line    => 'MAILTO=root',
    match   => '^MAILTO=',
    require => Package['rkhunter'],
  }
}
