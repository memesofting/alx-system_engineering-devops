file { '/tmp/school':
ensure     => file,
content    => 'I love puppet',
owner      => 'www-data',
group      => 'www-data'
permission => '0744',
}
