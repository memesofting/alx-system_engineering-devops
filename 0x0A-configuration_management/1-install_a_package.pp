# This manifest installs flask 2.1.0 using pip3
exec { 'install_flask2.1.0':
  command => '/usr/bin/pip install flask==2.1.0',
  path    => '/usr/bin',
}
