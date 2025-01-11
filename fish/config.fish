# Environment Variables
set -gx GPG_TTY (tty)
set -gx REPOS "$HOME/Repos"
set -gx CLICOLOR 1
set -gx LSCOLORS ExFxBxDxCxegedabagacad
set -gx TERM tmux-256color
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx BROWSER lynx
set -gx GITLAB_HOST 'https://gitlab.wpdesk.dev'
set -gx GLAMOUR_STYLE 'light'
set -gx BAT_THEME "ansi"
set -gx LESS "-FXR"
set -gx LESS_TERMCAP_mb (printf '\e[1;32m')
set -gx LESS_TERMCAP_md (printf '\e[1;32m')
set -gx LESS_TERMCAP_me (printf '\e[0m')
set -gx LESS_TERMCAP_se (printf '\e[0m')
set -gx LESS_TERMCAP_so (printf '\e[01;33m')
set -gx LESS_TERMCAP_ue (printf '\e[0m')
set -gx LESS_TERMCAP_us (printf '\e[1;4;31m')
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
set -gx SUDO_ASKPASS "$HOME/Scripts/dmenupass"
set -gx GOBIN "$HOME/.local/bin"
set -gx RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/ripgreprc"
set -gx DISPLAY :0

set -gx NT_ROOT "/home/bjaskulski/Repos/github.com/bart-jaskulski/me/notes"

set -gx ATAC_THEME "/home/bjaskulski/.config/atac/theme.toml"
set -gx ATAC_KEY_BINDINGS "/home/bjaskulski/.config/atac/keybinds.toml"

# Path modifications
fish_add_path "$HOME/Scripts"
fish_add_path "$HOME/.config/composer/vendor/bin"
fish_add_path "$HOME/.local/share/nvim/mason/bin"
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/go/bin"
fish_add_path "$PNPM_HOME"
fish_add_path "$HOME/bin"
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.bun/bin"

set -U fish_greeting

# CDPATH equivalent
set -gx CDPATH . $REPOS

# NVM setup
set -gx NVM_DIR "$HOME/.nvm"

if status is-interactive
  # Dircolors
  if type -q dircolors
    if test -r "$HOME/.dircolors"
      eval (dircolors -c "$HOME/.dircolors")
    else
      eval (dircolors -c)
    end
  end

  # Aliases
  abbr -a tm tmux
  abbr -a c composer
  abbr -a _ sudo
  abbr -a x exit
  abbr -a chmox chmod +x
  abbr -a k clear
  abbr -a e $EDITOR
  abbr -a g git
  abbr -a cal ncal -bM
  abbr -a cat bat
  # abbr -a lf nnn
  abbr -a auniq 'awk \'!x[$0]++\''

  function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
  end
  abbr --add dotdot --regex '^\.\.+$' --function multicd

  # FZF configuration
  set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse"

  # Use caps lock as shift lock if setxkbmap is available
  if type -q setxkbmap; and test -n "$DISPLAY"
    setxkbmap -option caps:shiftlock
  end

  fnm env --use-on-cd --shell fish | source

  envx ~/.env
end
