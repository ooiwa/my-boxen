class people::ooiwa {
 
  ## Puppet module
  include iterm2::stable
  include chrome
  include alfred
  include ruby::2_0_0
 
  ## homebrew
  package {
    [
      'tmux',
    ]:
  }
 
  ## dotfiles from github
  $home     = "/Users/${::luser}"
  $dotfiles = "${home}/dots"
 
  # git clone
  repository { $dotfiles:
    source  => "ooiwa/dots",
  }
 
  ## zsh
  package {
    'zsh':
      install_options => [
        '--disable-etcdir',
      ];
  }
 
  file_line { 'add zsh to /etc/shells':
    path    => '/etc/shells',
    line    => "${boxen::config::homebrewdir}/bin/zsh",
    require => Package['zsh'],
    before  => Osx_chsh[$::luser];
  }
 
  osx_chsh { $::luser:
    shell => "${boxen::config::homebrewdir}/bin/zsh";
  }
 
  ## settings
  exec { "osx-settings":
    cwd => $dotfiles,
    #creates => "${home}/.zshrc",
    command => "sh ${dotfiles}/osx -s",
    require => Repository[$dotfiles]
  }
}
