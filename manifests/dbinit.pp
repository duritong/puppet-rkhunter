class rkhunter::dbinit {
  exec{'init_rkunter_db':
    command => 'rkhunter --propupd',
    creates => '/var/lib/rkhunter/db/rkhunter.dat',
    require => Package['rkhunter'],
    path    => ['/sbin','/bin','/usr/bin','/usr/sbin'],
  }
}
