export PATH=$PATH:/usr/local/opt/ruby/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin:/usr/local/sbin
export PATH="/usr/local/bin:$PATH"
export NODE_PATH="/usr/local/lib/node"
export PATH="/usr/local/share/npm/bin:$PATH"
export PATH=$PATH:$HOME/.bin
# if rbenv is present, configure it for use
if which rbenv &> /dev/null; then
    # Put the rbenv entry at the front of the line
    export PATH="$HOME/.rbenv/bin:$PATH"

    # enable shims and auto-completion
    eval "$(rbenv init -)"
fi

# Setup terminal, and turn on colors
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad

# Enable color in grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR=32

# This resolves issues install the mysql, postgres, and other gems with native non universal binary extensions
export ARCHFLAGS='-arch x86_64'

export LESS='--ignore-case --raw-control-chars'
export PAGER='less'
export EDITOR='vim'
# CTAGS Sorting in VIM/Emacs is better behaved with this in place
export LC_COLLATE=C
