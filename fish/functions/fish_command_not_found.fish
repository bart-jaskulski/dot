function fish_command_not_found
    # Get all arguments as a single string
    set -l cmd_string (string join " " $argv)
    
    # Try to get existing command from saved conversation
    set -l ai_response (mods -q -s "$cmd_string" 2>/dev/null)
    set -l status_code $status
    
    if test $status_code -ne 0
        # If no saved conversation exists, ask AI with shell role
        set ai_response (mods -q -R shell -t "$cmd_string" "$cmd_string")
        set status_code $status
    end
    
    if test $status_code -eq 0
        while true
            # Ask for confirmation with bold command
            echo (set_color --bold)$ai_response(set_color normal)
            read -l -P "Run this command? [y/N/r] " confirm
            
            switch $confirm
                case y Y yes Yes YES
                    eval $ai_response
                    break
                case r R refine Refine REFINE
                    # Continue the conversation to refine the command
                    read -l -P "How should I refine this command? " refinement
                    set ai_response (mods -q -c "$cmd_string" "$refinement")
                    set status_code $status
                    
                    if test $status_code -ne 0
                        echo "Failed to refine command"
                        return 1
                    end
                case '*'
                    # If command wasn't used, delete the saved conversation
                    mods -q -d "$cmd_string" 2>/dev/null
                    return 1
            end
        end
    else
        echo "Failed to get AI suggestion"
        return 1
    end
end
# function fish_command_not_found
#     # Get all arguments as a single string
#     set -l cmd_string (string join " " $argv)
#
#     # Call mods and store the response
#     set -l ai_response (mods -qm flash -R shell -t "$cmd_string" "$cmd_string")
#
#     if test $status -eq 0
#         # Show the suggested command
#         echo "AI suggests running:"
#         echo $ai_response
#
#         # Ask for confirmation
#         read -l -P "Do you want to run this command? [y/N] " confirm
#
#         switch $confirm
#             case y Y yes Yes YES
#                 # Execute the command
#                 eval $ai_response
#             case '*'
#                 echo "Command cancelled"
#                 return 1
#         end
#     else
#         echo "Failed to get AI suggestion"
#         return 1
#     end
# end
