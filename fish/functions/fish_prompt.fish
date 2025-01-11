function fish_prompt
  echo -n (prompt_pwd)

  if git rev-parse --is-inside-work-tree 2>/dev/null >/dev/null
    echo -n (git \
    --no-pager \
    --no-optional-locks \
    status \
    --porcelain \
    --branch \
    2>/dev/null \
    | awk '
    BEGIN {
      c["reset"] = "\033[0m"
      c["bold"] = "\033[1m"
      c["italic"] = "\033[3m"
      c["underline"] = "\033[4m"
      c["reverse"] = "\033[7m"
      c["strike"] = "\033[9m"
      # Escape sequences for colors
      for (i in c) c[i] = "\x1b" substr(c[i], 2)
    }

    /^## / { branch = index($2,"...") ? substr($2, 1, index($2,"...")-1) : $2 }
    /^\?/ { count["?"]++ }
    /^\s?D / { count["-"]++ }
    /^\s?A / { count["+"]++ }
    /^\s?M / { count["󰦒"]++ }
    /^UU/ { count["UU"]++ }

    END {
      if (branch == "master" || branch == "main") {
        output = c["reverse"]
      } else {
        output = c["reset"]
      }
      output = " " output branch c["reset"] " "

      for (i in count) {
        output = output c["reset"] sprintf("%s%d ", i, count[i])
      }

      print output
    }
    ')
  end

  set_color normal
  echo

  if fish_is_root_user
    set_color --bold black
    echo -n '# '
  else
    set_color normal
    echo -n '$ '
  end
  set_color normal
end
