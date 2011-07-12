_venv() 
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="c a --help"
 
    case "${prev}" in
    a)
        local list=$(ls ~/.virtualenvs) 
        COMPREPLY=( $(compgen -W "${list}" -- ${cur}) )
        return 0
        ;;
    *)
        ;;
    esac
    
    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0

}
complete -F _venv venv
