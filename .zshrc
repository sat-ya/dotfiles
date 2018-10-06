export LANG=ja_JP.UTF-8
autoload -Uz colors
bindkey -v
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
PROMPT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~
%# "
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
	/usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

function _update_vcs_info_msg() {
	LANG=en_US.UTF-8 vcs_info
	RPROMPT="${vcs_info_msg_0_}"
}

add-zsh-hook precmd _update_vcs_info_msg
alias -g G='| grep'
alias -g L='| less'
alias containerremove='docker ps -aq | xargs docker rm'
alias containerstop='docker ps -aq | xargs docker stop'
alias cp='cp -i'
alias d="docker"
alias dir='ls'
alias dirs='dirs -v'
alias global='curl httpbin.org/ip'
alias grep='grep --color=auto'
alias h='history'
alias imageremove='docker images -aq | xargs docker rmi -f'
alias la='ls -Gal'
alias less='less -g -i -M -R -S -W -z-4 -x4'
alias ll='ls -Gal --color=auto'
alias mkdir='mkdir -p'
alias mv='mv -i'
alias path="echo $PATH | tr ':' '\n'"
alias ping8='ping 8.8.8.8'
alias rm='rm -i'
alias shutdown='sudo shutdown -h now'
bindkey '^R' history-incremental-pattern-search-backward
setopt auto_cd
setopt auto_pushd
setopt extended_glob
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt ignore_eof
setopt interactive_comments
setopt no_beep
setopt no_flow_control
setopt print_eight_bit
setopt pushd_ignore_dups
setopt share_history

if which pbcopy >/dev/null 2>&1 ; then
	alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
	alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
	alias -g C='| putclip'
fi

case ${OSTYPE} in
	darwin*)
		export CLICOLOR=1
		alias ls='ls -G -F'
		;;
	linux*)
		alias ls='ls -F --color=auto'
		;;
esac

bindkey '^R' history-incremental-pattern-search-backward
