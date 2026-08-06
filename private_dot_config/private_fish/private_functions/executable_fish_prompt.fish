function fish_prompt
    # This is a simple prompt. It looks like
    # alfa@nobby /path/to/dir $
    # with the path shortened and colored
    # and a "#" instead of a "$" when run as root.
    set -l symbol ' >>> '
    set -l color $fish_color_cwd
    if fish_is_root_user
        set symbol ' >>> '
        set -q fish_color_cwd_root
        and set color $fish_color_cwd_root
    end

    if test $CMD_DURATION -gt 59999 2>/dev/null
        set_color red
        printf "%03dM " (math --scale=0 $CMD_DURATION / 60000)
    else if test $CMD_DURATION -gt 999 2>/dev/null
        set_color green 
        printf "%03ds " (math --scale=0 $CMD_DURATION / 1000)
    else
        set_color cyan
        printf "%03dm " $CMD_DURATION
    end

    set_color normal
    echo -n (prompt_pwd)
  
    set -g __fish_git_prompt_char_dirtystate '*'
    set -g __fish_git_prompt_char_invalidstate '#'
    set -g __fish_git_prompt_char_stagedstate '+'
    set -g __fish_git_prompt_char_stashstate '$'
    set -g __fish_git_prompt_char_stateseparator '|'
    set -g __fish_git_prompt_char_cleanstate ''
    set -g __fish_git_prompt_use_informative_chars 1
    set -g __fish_git_prompt_show_informative_status true
    set -g __fish_git_prompt_showcolorhints 1

    set_color normal 
    echo -n (fish_git_prompt)
    set_color normal
    
    set_color blue
    echo -n $symbol
    set_color normal
end

function fish_command_not_found
    cd $argv[1]
end

function fish_title
    set -q argv[1]; or set argv (prompt_pwd)
    echo $argv
end
