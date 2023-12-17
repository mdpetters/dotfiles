# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export TERM=xterm


[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if ! type __git_ps1 &> /dev/null && [ -e /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
        . /usr/share/git-core/contrib/completion/git-prompt.sh
fi
if type __git_ps1 &> /dev/null; then
        export GIT_PS1_SHOWDIRTYSTATE=1
        export GIT_PS1_SHOWUNTRACKEDFILES=1
        export GIT_PS1_SHOWCOLORHINTS=1
        export PROMPT_DIRTRIM=2
        export PROMPT_COMMAND='__git_ps1 "[\u@\h \W]" "\\\$ "'
fi

alias gvim=lgvim 

./force.sh

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/petters/.juliaup/bin:*)
        ;;

    *)
        export PATH=/home/petters/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<
vicd()
{
    local dst="$(command vifm --choose-dir - "$@")"
    if [ -z "$dst" ]; then
        echo 'Directory picking cancelled/failed'
        return 1
    fi
    cd "$dst"
}

HISTSIZE=50000
HISTFILESIZE=50000
