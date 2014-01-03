class people::ooiwa {
  include skype
  include iterm2::stable
  include chrome
  include alfred

  $home     = "/Users/${::boxen_user}"
  $src      = "${home}/src"
  $dotfiles = "${src}/dotfiles"

  file { $src:
    ensure => directory
  }

  repository { $dotfiles:
    source  => "ooiwa/dotfiles",
    require => File[$src]
  }

  exec { "sh ${dotfiles}/install.sh":
    cwd => $dotfiles,
    creates => "${home}/.zshrc",
    require => Repository[$dotfiles],
  }
}