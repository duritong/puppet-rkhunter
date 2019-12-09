# manage a local_conf
define rkhunter::local_conf(
  String $content,
  Pattern[/^\d+$/] $order = '10',
){
  concat::fragment{
    "rhunter-local-${name}":
      target  => '/etc/rkhunter.conf.local',
      content => $content,
      order   => $order,
  }
}
