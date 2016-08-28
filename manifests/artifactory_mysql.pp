class { 'firewall':
  ensure => stopped,
}

$my_sql_override_options = {
  'mysqld' => {
    max_allowed_packet      => '8M',
    innodb_file_per_table   => '',
    innodb_buffer_pool_size => '1536M',
    tmp_table_size          => '512M',
    max_heap_table_size     => '512M',
    innodb_log_file_size    => '256M',
    innodb_log_buffer_size  => '4M',
    bind-address            => '10.20.1.2',
  }
}

class { '::mysql::server':
  override_options        => $my_sql_override_options
}

mysql::db { 'artifactory_db':
  user     => 'artifactory',
  password => 'my_passwd',
  dbname   => 'artdb',
  collate  => 'utf8_bin',
  charset  => 'utf8',
  grant    => 'ALL',
  host     => '%',
  require  => Class['::mysql::server'],
}
