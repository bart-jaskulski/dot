function envx
    # Default to $HOME/.env if no argument provided
    set -l envfile $argv[1]
    test -z "$envfile"; and set envfile "$HOME/.env"
    
    # Check if file exists
    if not test -e "$envfile"
        echo "$envfile not found"
        return 1
    end

    # Read and process each line
    while read -l line
        # Skip empty lines and comments
        string match -qr '^[[:space:]]*$|^#' -- "$line"; and continue
        
        # Split into name and value
        set -l name (string split -m 1 = $line)[1]
        set -l value (string split -m 1 = $line)[2]
        
        # Export the variable
        set -gx $name $value
    end < $envfile
end
