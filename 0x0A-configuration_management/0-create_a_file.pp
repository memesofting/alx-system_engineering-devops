# Create file with permissions
file { '/tmp/school':
ensure  => file,
content => 'I love puppet',
owner   => 'www-data',
group   => 'www-data',
mode    => '0744',
}
