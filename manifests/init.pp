# manage rkhunter
# Copyright (C) 2007 admin@immerda.ch
#
# * local_conf: Array of /etc/rkhunter.conf.local lines
class rkhunter(
  $local_conf = []
) {
  case $::operatingsystem {
    gentoo: { include rkhunter::gentoo }
    centos: { include rkhunter::centos }
    default: { include rkhunter::base }
  }
}
