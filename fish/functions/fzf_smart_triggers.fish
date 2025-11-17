function fzf_smart_triggers
    set -l cmdline (commandline -opc)
    if test (count $cmdline) -eq 0; commandline -f complete; return; end

    set -l cmd $cmdline[1]
    set -l token (commandline -ct)

    switch $cmd
        # case git
        #     switch $cmdline[2]
        #         case sw switch checkout
        #             _fzf_helper_git_switch $token
        #             return
        #         case add a
        #             if test (count $cmdline) -eq 2
        #                 _fzf_helper_git_add
        #                 return
        #             end
        #     end
        case vim nvim vi
            if test (count $cmdline) -le 2
                _fzf_helper_editor_files $cmd $token
                return
            end
        # case cp
        #     if test (count $cmdline) -eq 1
        #         _fzf_helper_select_sources $cmd
        #         return
        #     end
        # case mv
        #     if test (count $cmdline) -eq 2
        #         _fzf_helper_interactive_rename $cmdline[2]
        #         return
        #     else if test (count $cmdline) -eq 1
        #         _fzf_helper_select_sources $cmd
        #         return
        #     end
    end
    commandline -f complete
end

# ==============================================================================
# 2. GIT HANDLERS (With correct signal handling)
# ==============================================================================

function _fzf_helper_git_switch -a query
    if not git rev-parse --git-dir >/dev/null 2>&1; commandline -f complete; return; end

    set -l branches (git branch -a --format='%(refname:short) %(if)%(HEAD)%(then)*%(end) %(upstream:track)')
    set -l worktrees (git worktree list --porcelain | awk '/^worktree/ {wt=$2} /^branch/ {print $2, wt}' | sed 's|refs/heads/||')
    set -l fzf_list
    for branch in $branches
        set -l display $branch
        for wt in $worktrees
            if string match -q -- (string split ' ' -- $wt)[1] (string split ' ' -- $branch)[1]
                set display "$branch 📁"; break
            end
        end
        set -a fzf_list $display
    end
    set -a fzf_list "➕ Create new branch..."

    set -l selected (printf "%s\n" $fzf_list | fzf --height=60% --layout=reverse --border=sharp --info=hidden \
        --prompt="> " --header="[Enter] Switch/CD | [Ctrl-N] Create New" \
        --preview="git log --oneline --graph --color=always -15 (echo {} | awk '{print \$1}')" \
        --preview-window="right:60%:noborder" --query="$query")

    if test -n "$selected"
        commandline -r ""
        set -l branch_name (echo "$selected" | awk '{print $1}')
        if test "$branch_name" = "➕"
            read -P "Enter new branch name: " new_branch
            if test -n "$new_branch"; commandline -i "git switch -c $new_branch"; and commandline -f execute; end
        else if string match -q -- "*📁*" "$selected"
            for wt in $worktrees
                if string match -q "$branch_name*" "$wt"
                    set -l path (string split ' ' -- $wt)[2]
                    cd (string escape -- $path)
                    commandline -f execute
                    break
                end
            end
        else
            commandline -i "git switch $branch_name"; and commandline -f execute
        end
    end

    commandline -f repaint
end

function _fzf_helper_git_add
    function _fzf_git_add_action -a action file
        switch $action
            case add; git add -- $file
            case patch; command git add -p -- $file < /dev/tty
            case unstage; git reset -- $file
            case view; git diff --color=always HEAD -- $file | less -R
        end
    end
    functions -c _fzf_git_add_action _fzf_git_add_action_exported
    set -l fzf_loader 'git status --porcelain | while read -l line; set -l s (string sub -l 2 -- $line); set -l f (string sub -s 4 -- $line); echo $s " " $f; end'
    eval $fzf_loader | fzf --height=80% --layout=reverse --border=sharp --info=hidden --no-preview \
        --header="[a]dd | [p]atch | [u]nstage | [Ctrl-V]iew diff | [q]uit" --prompt="> " \
        --bind="a:execute(_fzf_git_add_action_exported add {+2})+reload($fzf_loader)" \
        --bind="p:execute-silent(_fzf_git_add_action_exported patch {+2})+reload($fzf_loader)" \
        --bind="u:execute(_fzf_git_add_action_exported unstage {+2})+reload($fzf_loader)" \
        --bind="ctrl-v:execute-silent(_fzf_git_add_action_exported view {+2})" \
        --bind="q:abort,enter:abort"
    functions -e _fzf_git_add_action_exported
    commandline -r ""

    commandline -f repaint
end


# ==============================================================================
# 3. FILE & EDITOR HANDLERS (With correct signal handling)
# ==============================================================================

function _fzf_helper_editor_files -a editor query
    set -l find_cmd "find . -type f"

    set -l preview_options "right:60%:noborder"
    if test "$COLUMNS" -lt 120
        set preview_options "down:60%"
    end

    if command -q fd; set find_cmd "fd --type f --hidden --follow --exclude .git"; end
    set -l selected_files (eval $find_cmd | fzf --multi --height=80% --layout=reverse --border=sharp --info=hidden \
        --prompt="> " --header="[Tab] Select | [Enter] Open" \
        --preview="bat --color=always --style=plain --line-range :200 {} || head -n 50 {}" \
        --preview-window="$preview_options" --query="$query")
   
    if test -n "$selected_files"
        set -l cmd_to_run $editor
        for file in (string split0 -- $selected_files)
            if test -n "$file"
                set -a cmd_to_run (string escape -- "$file")
            end
        end

        if test (count $cmd_to_run) -gt 1
            commandline -r (string join " " $cmd_to_run)
            commandline -f execute
        end
    end

    commandline -f repaint
end

function _fzf_helper_select_sources -a cmd
    set -l selected_files (fd --type f --hidden --follow --exclude .git . | fzf --multi --height=80% --layout=reverse --border=sharp --info=hidden \
        --prompt="> " --header="[Tab] Select files to $cmd" \
        --preview="bat --color=always --style=plain --line-range :200 {} || head -n 50 {}" \
        --preview-window="right:60%:noborder")
    if test -n "$selected_files"
        commandline -r "$cmd (string escape -- $selected_files | string join ' ') "
    end

    commandline -f repaint
end

function _fzf_helper_interactive_rename -a source_file
    read -P "Rename to: " -l -- "$source_file" new_name
    if test $status -eq 0
        commandline -r "mv -- (string escape -- $source_file) (string escape -- $new_name)"
        commandline -f execute
    end

    commandline -f repaint
end
