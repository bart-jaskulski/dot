function envx
  set -l envfile $argv[1]
  test -z "$envfile"; and set envfile "$HOME/.env"

  if not test -e "$envfile"
    echo "$envfile not found"
    return 1
  end

  while read -l line
    string match -qr '^[[:space:]]*$|^#' -- "$line"; and continue

    set -l kv (string split = $line)
    set -gx $kv[1] $kv[2]
  end < $envfile
end
