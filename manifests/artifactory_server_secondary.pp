$license_key = @(LICENSE)
cHJvZHVjdHM6CiAgYXJ0aWZhY3Rvcnk6CiAgICBwcm9kdWN0OiBaWGh3YVhKbGN6b2dNakF4Tmkw
d09TMHlNbFF3TWpvMU56bzFPUzQ1T1RKYUNtbGtPaUJoTWpVNE1UVXhZaTFtTW1VMUxUUXlOR0l0
WVROak15MHlNbVJsTlRZeFlUWmtPVE1LYjNkdVpYSTZJRUYxZEc5emRISjFZM1IxY21VS2NISnZj
R1Z5ZEdsbGN6b2dlMzBLYzJsbmJtRjBkWEpsT2lCdWRXeHNDblJ5YVdGc09pQjBjblZsQ25SNWNH
VTZJRlJTU1VGTUNuWmhiR2xrUm5KdmJUb2dNakF4Tmkwd09DMHlNMVF3TWpvMU56bzFPUzQ1T1RK
YUNnPT0KICAgIHNpZ25hdHVyZTogWllYcXpHcjI2NDBJcjlRdkxlZ1kyVXpBL0ZNZkRmcVN6bStU
andyVVhFVytKb0RFckgzQ3FKYWNzdDJaRS9nNUhmWGFOZ0g1OVpiNHVONnV1aUtoVVJXNStzWmpY
eVpZRDlDSGJhdnJjK0lRTXdodkNkNFBPUDkwYWtMTjg4V1dHS01uTytCSjArUWFZT3Q2V0RaRUtY
Skg5OWVTYS9kMllUdnJrNEhKZ0ViaWw1azJ0VDFvSzBtTE9ycjJSQ004ZW5kaHloWWQ0dFRNdEdv
MmViSmQyVENEVnZYekcrbGs2enNKOU1tTDJCMEhmWDJFMWo1NGlwVGU5OVZEVlFmRTl0MG9iaTh1
cytUamtOUG9MV0ZIdnRSQ0Eva29aalZKVGViUVlmUC9vY240VU5QelVHUmh6Zm4zS1RLaTdITE4w
YTl2SDBrdG1sazdJOGUrNGo1SDVnPT0KdmVyc2lvbjogMQo=
|-LICENSE

class { 'firewall':
  ensure => stopped,
}

class { '::artifactory_ha':
  license_key     => $license_key,
  jdbc_driver_url => 'http://artifactory.azcender.com/artifactory/ext-release-local/com.mysql/mysql-connector-java/5.1.39/mysql-connector-java-5.1.39.jar',
  db_type         => 'mysql',
  db_url          => 'jdbc:mysql://database:3306/artdb?characterEncoding=UTF-8&elideSetAutoCommits=true',
  db_username     => 'artifactory',
  db_password     => 'my_passwd',
  security_token  => 'ABC1MY0Token1',
  is_primary      => false,
  cluster_home    => '/nfs/mount/location',
}
