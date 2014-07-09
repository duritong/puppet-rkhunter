# initialize the database
class rkhunter::dbinit {
  exec{'init_rkunter_db':
    command => 'rkhunter --propupd',
    creates => '/var/lib/rkhunter/db/rkhunter.dat',
    require => File['/etc/rkhunter.conf.local'],
  }
}
