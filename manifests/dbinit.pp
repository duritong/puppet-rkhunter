class rkhunter::dbinit {
    exec{'init_rkunter_db':
        command => '/usr/bin/rkhunter --propupd',
        creates => '/var/lib/rkhunter/db/rkhunter.dat',
        require => Package['rkhunter'],
    }
}
