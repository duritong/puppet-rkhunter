# manage gentoo related things
class rkhunter::gentoo inherits rkhunter::base {
  Package[rkhunter]{
    category => 'app-forensics',
  }
}
