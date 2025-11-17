#!/usr/bin/env fish

# Git Worktree Manager
# Usage: wt <command> [args]

function wt
    set -l cmd $argv[1]
    set -l args $argv[2..]
    
    # Check if we're in a git repository
    if not git rev-parse --git-dir >/dev/null 2>&1
        echo "Error: Not in a git repository" >&2
        return 1
    end
    
    # Get the git common directory (bare repo root)
    set -l git_common_dir (git rev-parse --git-common-dir)
    set -l worktrees_dir "$git_common_dir/worktrees"
    
    switch $cmd
        case add
            _wt_add $args $worktrees_dir
        case cd
            _wt_cd $args $worktrees_dir
        case list ls
            _wt_list $worktrees_dir
        case remove rm
            _wt_remove $args $worktrees_dir
        case help -h --help
            _wt_help
        case '*'
            if test -z "$cmd"
                _wt_help
            else
                echo "Error: Unknown command '$cmd'" >&2
                _wt_help
                return 1
            end
    end
end

function _wt_add
    set -l branch_name $argv[1]
    set -l worktrees_dir $argv[2]
    
    if test -z "$branch_name"
        echo "Error: Branch name required" >&2
        echo "Usage: wt add <branch-name>" >&2
        return 1
    end
    
    # Extract basename from branch name for directory
    set -l dir_name (basename "$branch_name")
    set -l worktree_path "$worktrees_dir/$dir_name"
    
    # Create worktrees directory if it doesn't exist
    mkdir -p "$worktrees_dir"
    
    # Check if worktree directory already exists
    if test -d "$worktree_path"
        echo "Error: Worktree directory '$worktree_path' already exists" >&2
        return 1
    end
    
    # Add the worktree
    echo "Creating worktree for branch '$branch_name' at '$worktree_path'"
    # TODO: guess default branch
    git worktree add -b "$branch_name" "$worktree_path" "main"
end

function _wt_cd
    set -l branch_name $argv[1]
    set -l worktrees_dir $argv[2]
    
    if test -z "$branch_name"
        echo "Error: Branch name required" >&2
        echo "Usage: wt cd <branch-name>" >&2
        return 1
    end
    
    # Extract basename from branch name for directory
    set -l dir_name (basename "$branch_name")
    set -l worktree_path "$worktrees_dir/$dir_name"
    
    if not test -d "$worktree_path"
        echo "Error: Worktree '$worktree_path' does not exist" >&2
        return 1
    end
    
    # Change to the worktree directory
    cd "$worktree_path"
    echo "Switched to worktree: $worktree_path"
end

function _wt_list
    set -l worktrees_dir $argv[1]
    
    echo "Git worktrees:"
    git worktree list
    
    if test -d "$worktrees_dir"
        echo ""
        echo "Available worktrees in $worktrees_dir:"
        for dir in "$worktrees_dir"/*
            if test -d "$dir"
                set -l branch_info (git -C "$dir" branch --show-current 2>/dev/null)
                if test -n "$branch_info"
                    echo "  $(basename "$dir") -> $branch_info"
                else
                    echo "  $(basename "$dir")"
                end
            end
        end
    end
end

function _wt_remove
    set -l branch_name $argv[1]
    set -l worktrees_dir $argv[2]
    
    if test -z "$branch_name"
        echo "Error: Branch name required" >&2
        echo "Usage: wt remove <branch-name>" >&2
        return 1
    end
    
    # Extract basename from branch name for directory
    set -l dir_name (basename "$branch_name")
    set -l worktree_path "$worktrees_dir/$dir_name"
    
    if not test -d "$worktree_path"
        echo "Error: Worktree '$worktree_path' does not exist" >&2
        return 1
    end
    
    echo "Removing worktree: $worktree_path"
    git worktree remove "$worktree_path"
end

function _wt_help
    echo "Git Worktree Manager"
    echo ""
    echo "Usage: wt <command> [args]"
    echo ""
    echo "Commands:"
    echo "  add <branch-name>    Create a new worktree for the specified branch"
    echo "  cd <branch-name>     Change to the worktree directory"
    echo "  list, ls             List all worktrees"
    echo "  remove, rm <branch>  Remove a worktree"
    echo "  help, -h, --help     Show this help message"
    echo ""
    echo "Examples:"
    echo "  wt add feat/doomscroll    # Creates worktree at worktrees/doomscroll for branch feat/doomscroll"
    echo "  wt cd main                # Change to worktrees/main directory"
    echo "  wt list                   # Show all worktrees"
    echo "  wt remove feat/doomscroll # Remove the doomscroll worktree"
end

# Completions for the wt command
complete -c wt -f

# Complete subcommands
complete -c wt -n '__fish_use_subcommand' -a 'add' -d 'Create a new worktree'
complete -c wt -n '__fish_use_subcommand' -a 'cd' -d 'Change to worktree directory'
complete -c wt -n '__fish_use_subcommand' -a 'list ls' -d 'List all worktrees'
complete -c wt -n '__fish_use_subcommand' -a 'remove rm' -d 'Remove a worktree'
complete -c wt -n '__fish_use_subcommand' -a 'help' -d 'Show help'

# Complete branch names for 'add' command
complete -c wt -n '__fish_seen_subcommand_from add' -a '(git branch -r | sed "s/.*\///" | grep -v HEAD)'

# Complete existing worktrees for 'cd' and 'remove' commands
function __wt_complete_worktrees
    if git rev-parse --git-dir >/dev/null 2>&1
        set -l git_common_dir (git rev-parse --git-common-dir)
        set -l worktrees_dir "$git_common_dir/worktrees"
        if test -d "$worktrees_dir"
            for dir in "$worktrees_dir"/*
                if test -d "$dir"
                    basename "$dir"
                end
            end
        end
    end
end

complete -c wt -n '__fish_seen_subcommand_from cd remove rm' -a '(__wt_complete_worktrees)'
