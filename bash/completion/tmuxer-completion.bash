_tmuxer() 
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="ls run del open help version"
 
    case "${prev}" in
    run|del|rm|open )
            local list=$(ls ~/.tmuxer/tmux_files |awk -F '.' '{print $1}')
            COMPREPLY=( $(compgen -W "${list}" -- ${cur}) )
            return 0
            ;;
    *)
        ;;
    esac
    
    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0

}
complete -F _tmuxer tmuxer
complete -F _tmuxer tmx
