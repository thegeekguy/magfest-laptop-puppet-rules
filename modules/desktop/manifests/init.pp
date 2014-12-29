class desktop {
  package { ['mate', 'lightdm', 'xorg-server', 'xorg-server-utils']:
    ensure => present
  } ->
  package { ['xorg-xinit', 'mate-terminal', 'lightdm-gtk3-greeter']:
    ensure => present
  } ->
  package { ['xorg-xrandr', 'mate-extra', 'yelp', 'curl', 'dnsutils']:
    ensure => present
  } ->
  package { ['tcpdump', 'traceroute', 'wget', 'bzip2', 'gzip']:
    ensure => present
  }
  package { ['tar', 'zip', 'unzip', 'p7zip', 'xz', 'arj', 'unrar']:
    ensure => present
  }
  package { ['unace', 'caja', 'atril', 'pluma', 'stone-soup', 'rxvt']:
    ensure => present
  }
  package { ['chromium', 'firefox', 'python2', 'python2-pygame']:
    ensure => present
  }
  service { 'lightdm':
    enable => true,
    subscribe => File['/etc/lightdm/lightdm.conf']
  }
  file { '/etc/systemd/system/multi-user.target.wants/display-manager.service':
    ensure => link, 
    target => '/etc/systemd/system/display-manager.service'
  }
  package { 'ruby-shadow':
    ensure => present
  } ->
  group { 'autologin':
    ensure => present
  } ->
  user { 'magfest':
    ensure => present,
    password => '$1$ZUm6eWmc$ox8kBH436StQXy8Bv.rgK.',
    groups => 'autologin'
  }
  file { '/usr/share/magfest':
    ensure => directory
  }
  file { '/usr/share/magfest/highreslogo.png':
    ensure => file,
    source => 'puppet:///modules/desktop/highreslogo.png'
  }
  file { '/etc/lightdm/lightdm-gtk-greeter.conf':
    ensure => file,
    source => 'puppet:///modules/desktop/lightdm-gtk-greeter.conf'
  }
  file { '/etc/lightdm/lightdm.conf':
    ensure => file,
    source => 'puppet:///modules/desktop/lightdm.conf'
  }
  file { '/usr/share/glib-2.0/schemas/mate-background.gschema.override':
    ensure => file,
    source => 'puppet:///modules/desktop/mate-background.gschema.override'
  }
}
