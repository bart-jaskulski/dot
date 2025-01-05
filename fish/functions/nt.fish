function nt -d "Create a new numbered directory with README.md"
    if not set -q NT_ROOT
        echo "Error: NT_ROOT environment variable is not set"
        return 1
    end

    if not test -d $NT_ROOT
        echo "Error: $NT_ROOT directory does not exist"
        return 1
    end

    # Get all numeric directory names
    set -l dirs (find $NT_ROOT -maxdepth 1 -type d -exec basename {} \; | string match -r '^[0-9]+$' | sort -n)
    
    # Set next ID
    set -l next_id 1
    if test (count $dirs) -gt 0
        set next_id (math (echo $dirs[-1]) + 1)
    end

    # Create new directory
    set -l new_dir $NT_ROOT/$next_id
    mkdir $new_dir
    or begin
        echo "Error: Failed to create directory $new_dir"
        return 1
    end

    # Create README.md with optional title
    set -l readme $new_dir/README.md
    if test (count $argv) -gt 0
        echo "# $argv" > $readme
    else
        touch $readme
    end
    or begin
        echo "Error: Failed to create $readme"
        rm -r $new_dir
        return 1
    end

    if set -q EDITOR
        eval $EDITOR $readme
    else
        vi $readme
    end

    # Extract title from first line and add to git
    set -l title (head -n 1 $readme | string replace -r '^# ' '')
    if test -z "$title"
        set title "Add note"
    end

    git -C $NT_ROOT add $next_id
    git -C $NT_ROOT commit -m "$title"
end
