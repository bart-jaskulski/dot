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

set -gx NNN_OPTS aPEH
set -gx NNN_PLUG "f:finder;v:preview-tui"

set -gx NT_ROOT "/home/bjaskulski/Repos/github.com/bart-jaskulski/me/notes"

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

# Key bindings
function fish_user_key_bindings
  fish_default_key_bindings -M
  #
  # # Vi mode
  # fish_vi_key_bindings --no-erase
  #

  bind \ek up-or-search
  bind \ej down-or-search

  bind \ef accept-autosuggestion
  bind \el complete

  # fzf --fish | source
  # Ctrl+R for history search using fzf
  # bind \cr _fzf_search_history
end

# Prompt customization
function fish_prompt
  set -l last_status $status

  set_color magenta
  echo -n (prompt_pwd)

  if git rev-parse --is-inside-work-tree 2>/dev/null >/dev/null
    set -l git_info (git \
    --no-pager \
    --no-optional-locks \
    status \
    --porcelain=v2 \
    --branch \
    2>/dev/null \
    | awk '
    BEGIN {
    c["reset"] = "\033[0m"
    c["italic"] = "\033[3m"
    c["red"] = "\033[31m"
    c["green"] = "\033[32m"
    c["yellow"] = "\033[33m"
    c["blue"] = "\033[34m"
    c["strong"] = "\033[7m"
    # Fish uses different escape sequences for colors in prompt
    for (i in c) c[i] = "\x1b" substr(c[i], 2)
    }

    /^# branch\.head/ { branch = $3 }
    /^\?/ { count[c["reset"] c["italic"] "?"]++ }
    /^[0-9] A. / { count[c["green"] "+"]++ }
    /^[0-9] .M / { count[c["yellow"] "󰦒"]++ }
    /^[0-9] .D / { count[c["red"] "-"]++ }
    /^u UU/ { count[c["strong"] "UU"]++ }

    END {
    if (branch == "master" || branch == "main") {
    output = c["red"]
    } else {
    output = c["green"]
    }
    output = output "\t " branch "\t"

    if (length(count) > 0) {
    output = output c["blue"]
    for (i in count) {
    output = output sprintf("%s%d ", i, count[i])
    }
    output = output " "
    }
    print output
    }
    ')
    echo -n $git_info
  end

  set_color normal
  echo

  if fish_is_root_user
    set_color red
    echo -n '# '
  else
    set_color blue
    echo -n '$ '
  end
  set_color normal
end


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
  abbr -a ls ls -h --color=auto
  abbr -a ll ls -al
  abbr -a la ls -AF
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
  set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border"

  # Use caps lock as shift lock if setxkbmap is available
  if type -q setxkbmap; and test -n "$DISPLAY"
    setxkbmap -option caps:shiftlock
  end

  zoxide init fish | source

  fnm env --use-on-cd --shell fish | source

  envx ~/.env
end
