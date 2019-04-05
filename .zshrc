alias apachectl='sudo apachectl'
alias containerremove='docker ps -aq | xargs docker rm'
alias containerstop='docker ps -aq | xargs docker stop'
alias doc='docker'
alias de='cd /Users/sat/Desktop'
alias dir='ls'
alias global='curl httpbin.org/ip'
alias grep='grep --color=auto'
alias h='history'
alias imageremove='docker images -aq | xargs docker rmi -f'
alias less='less -g -i -M -R -S -W -z-4 -x4'
alias ll='ls -Gal'
alias ls='ls -al'
alias lsof='lsof -n -P -i'
alias path="echo $PATH | tr ':' '\n'"
alias ping8='ping 8.8.8.8'
alias renew='sudo ipconfig set en0 DHCP'
alias rm='rmtrash'
alias shutdown='sudo shutdown -h now'
alias su='su -'
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias web='cd ~/html'
# alias playtest='cd ~/python/nowplaying && python ~/python/nowplaying/command.py'
# alias playtweet='cd ~/python/nowplaying/ && python ~/python/nowplaying/nowplaying.py'
alias debuggit='ssh -vT git@github.com'
alias pip='pip3'
# https://github.com/yonchu/shell-color-pallet
alias color='sh ~/shell-color-pallet/color256'
alias pat='(){cp -i ~/py_template.py $1 && vim $1}'
alias jat='(){cp -i ~/ja_template.java $1 && vim $1}'

# https://qiita.com/mollifier/items/40d57e1da1b325903659
autoload -Uz colors
colors
PROMPT="%~)"


# https://qiita.com/ms-rock/items/6e4498a5963f3d9c4a67
# export PYENV_ROOT=${HOME}/.pyenv
# if [ -d "${PYENV_ROOT}" ]; then
# 	export PATH=${PYENV_ROOT}/bin:$PATH
# 	eval "$(pyenv init -)"
# 	eval "$(pyenv virtualenv-init -)"
# fi


# for tmux
# https://saitodev.co/article/zsh%E3%81%AE%E8%B5%B7%E5%8B%95%E3%81%A8%E5%90%8C%E6%99%82%E3%81%ABtmux%E3%82%82%E8%B5%B7%E5%8B%95%E3%81%97%E3%81%A6%E3%81%BB%E3%81%97%E3%81%84
[[ -z "$TMUX" && ! -z "$PS1" ]] && tmux

# for pull-request from git command
eval "$(hub alias -s)"

# change default editor
export EDITOR=vi

# Mac vim
# export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim

# change nano
export VISUAL=vim

# ターミナルでググる
google(){
	if [ $(echo $1 | egrep "^-[cfs]$") ]; then
		local opt="$1"
		shift
	fi
	local url="https://www.google.co.jp/search?q=${*// /+}"
	local app="/Applications"
	local g="${app}/Google Chrome.app"
	local f="${app}/Firefox.app"
	local s="${app}/Safari.app"
	case ${opt} in
		"-g")   open "${url}" -a "$g";;
		"-f")   open "${url}" -a "$f";;
		"-s")   open "${url}" -a "$s";;
		*)      open "${url}";;
	esac
}
# 少し凝った zshrc
# License : MIT
# http://mollifier.mit-license.org/

########################################
# 環境変数
export LANG=ja_JP.UTF-8

# 色を使用出来るようにする
autoload -Uz colors
colors

# vim 風キーバインドにする
bindkey -v

# ヒストリの設定
HISTSIZE=1000000
SAVEHIST=1000000

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

########################################
# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg

########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

# 誤り訂正
setopt correct

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi

########################################
# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        alias ls='ls -F --color=auto'
esac

# https://qiita.com/1000ch/items/93841f76ea52551b6a97
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)" >> ~/.bash_profile

# https://qiita.com/anieca/items/bf8aa2db5139834ae2ad
export PATH="$HOME/.local/bin:$PATH"
export PIPENV_VENV_IN_PROJECT=1

# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zhistory
# 履歴をインクリメンタルに追加
setopt inc_append_history
# インクリメンタルからの検索
# これはbindkey -vの後ろの持ってくる必要がある
# http://d.hatena.ne.jp/cooldaemon/20060925/1159156394
bindkey "^R" history-incremental-search-backward

# AtCoder用Javaの設定
export JAVA_HOME=`/usr/libexec/java_home -v "1.8"`
export PATH=${JAVA_HOME}/bin:${PATH}
