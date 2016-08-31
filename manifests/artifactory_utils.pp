artifact_sync { '/tmp/sample.war':
  ensure     => present,
  source_url => 'http://artifactory.azcender.com/artifactory/temp/org/apache/sample/1.0.0/sample-1.0.0.war',
}

artifact_sync { '/tmp/sample2.war':
  ensure     => present,
  source_url => 'http://artifactory.azcender.com/artifactory/test-basic/org/apache/sample/1.0.0/sample-1.0.0.war',
  user       => 'test-basic',
  password   => 'password',
}
