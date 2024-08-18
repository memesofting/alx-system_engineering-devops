# script fixes apache 500 error

# Define the path to the php.ini file
$php_ini_path = '/etc/php5/apache2/php.ini'
$wp_settings_path = '/var/www/html/wp-settings.php'

# Ensure the php.ini file has the correct settings
file_line { 'display_errors':
  path   => $php_ini_path,
  line   => 'display_errors = On',
  match  => '^display_errors',
  notify => Service['apache2'], # Notify Apache to restart if the file changes
}

file_line { 'display_startup_errors':
  path   => $php_ini_path,
  line   => 'display_startup_errors = On',
  match  => '^display_startup_errors',
  notify => Service['apache2'], # Notify Apache to restart if the file changes
}

file_line { 'error_reporting':
  path   => $php_ini_path,
  line   => 'error_reporting = E_ALL',
  match  => '^error_reporting',
  notify => Service['apache2'], # Notify Apache to restart if the file changes
}

file_line { 'fix_require_once_line_137':
  path   => $wp_settings_path,
  line   => 'require_once( ABSPATH . WPINC . \'/class-wp-locale.php\' );',
  match  => '^require_once\( ABSPATH \. WPINC \. \'/class-wp-locale.phpp\' \);',
  notify => Service['apache2'], # Optional: Notify Apache to restart if this file is critical to web service
}

# Ensure Apache is restarted to apply the changes
service { 'apache2':
  ensure => running,
  enable => true, # Restart Apache if php.ini changes
}
