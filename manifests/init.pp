class icinga {

  apt::source { 'formorer-icinga':
    release    => 'trusty',
    repos      => 'main',
    location   => 'http://ppa.launchpad.net/formorer/icinga/ubuntu',
    key        => '36862847',
    key_server => 'keyserver.ubuntu.com',
  }

  package { 'icinga':
    ensure  => present,
    require => Apt::Source['formorer-icinga'],
  }

  service { 'icinga':
    ensure  => running,
    require => Package['icinga']
  }

}
