set -U fish_greeting

set -gx GPG_TTY (tty)
set -gx CLICOLOR 1
set -gx LSCOLORS ExFxBxDxCxegedabagacad
set -gx TERM xterm-256color
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx BROWSER lynx
set -gx LESS "-FXR"
set -gx LESS_TERMCAP_mb (printf '\e[1;32m')
set -gx LESS_TERMCAP_md (printf '\e[1;32m')
set -gx LESS_TERMCAP_me (printf '\e[0m')
set -gx LESS_TERMCAP_se (printf '\e[0m')
set -gx LESS_TERMCAP_so (printf '\e[01;33m')
set -gx LESS_TERMCAP_ue (printf '\e[0m')
set -gx LESS_TERMCAP_us (printf '\e[1;4;31m')
set -gx GOBIN "$HOME/.local/bin"

# set -gx DISPLAY :0

set -gx NT_ROOT "/home/bjaskulski/Repos/github.com/bart-jaskulski/me/notes"

set -gx ATAC_KEY_BINDINGS "/home/bjaskulski/.config/atac/keybinds.toml"
set -gx ATAC_THEME "/home/bjaskulski/.config/atac/theme.toml"
set -gx BAT_THEME "ansi"
set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse"
set -gx GITLAB_HOST 'https://gitlab.wpdesk.dev'
set -gx GLAMOUR_STYLE 'light'
set -gx RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/ripgreprc"

fish_add_path "$HOME/Scripts"
fish_add_path "$HOME/.config/composer/vendor/bin"
fish_add_path "$HOME/.local/share/nvim/mason/bin"
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/go/bin"
fish_add_path "$HOME/bin"
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.npm-global/bin"
fish_add_path "$HOME/Repos/github.com/pyenv/pyenv/bin"

status --is-interactive; and pyenv init - | source

set -gx REPOS "$HOME/Repos"
set -gx CDPATH . "$REPOS/gitlab.wpdesk.dev" . "$REPOS/github.com/bart-jaskulski" . "$REPOS/github.com" . "$REPOS"

if status is-interactive
  if type -q dircolors
    if test -r "$HOME/.dircolors"
      eval (dircolors -c "$HOME/.dircolors")
    else
      eval (dircolors -c)
    end
  end

  if test (tty) = "/dev/tty1"; and not set -q DISPLAY; and not set -q WAYLAND_DISPLAY
    exec river -no-xwayland
  end

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
  abbr -a auniq 'awk \'!x[$0]++\''

  function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
  end
  abbr --add dotdot --regex '^\.\.+$' --function multicd


  # Use caps lock as shift lock if setxkbmap is available
  if type -q setxkbmap; and test -n "$DISPLAY"
    setxkbmap -option caps:shiftlock
  end

  fnm env --use-on-cd --shell fish | source

  envx ~/.env
end
