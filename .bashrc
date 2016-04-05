#
# ~/.bashrc
#

###################
#   Some Colors   #
###################
BLACK='\e[0;30m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
CYAN='\e[0;36m'
RED='\e[0;31m'
PURPLE='\e[0;35m'
BROWN='\e[0;33m'
LIGHTGRAY='\e[0;37m'
DARKGRAY='\e[1;30m'
LIGHTBLUE='\e[1;34m'
LIGHTGREEN='\e[1;32m'
LIGHTCYAN='\e[1;36m'
LIGHTRED='\e[1;31m'
LIGHTPURPLE='\e[1;35m'
YELLOW='\e[1;33m'
WHITE='\e[1;37m'
NC='\e[0m'              # No Color


#######################
#  Some Bash Options  #
#######################
# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


#################
#    Aliases    #
#################
# To temporarily bypass an alias, we preceed the command with a \
# EG:  the ls command is aliased, but to use the normal ls command you would
# type \ls
alias ls='ls -ah --color=auto'
alias ll='ls -lt'
alias df='df -h'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias lr='ls -lRha'
alias back='cd $OLDPWD'
alias vi='vim'


#################
#     Prompt    #
#################
#PS1='\a[\u@\h \W]\$ ' #standard prompt
# color_name='\[\033[ color_code m\]'
rgb_restore='\[\033[00m\]'
rgb_black='\[\033[00;30m\]'
rgb_firebrick='\[\033[00;31m\]'
rgb_red='\[\033[01;31m\]'
rgb_forest='\[\033[00;32m\]'
rgb_green='\[\033[01;32m\]'
rgb_brown='\[\033[00;33m\]'
rgb_yellow='\[\033[01;33m\]'
rgb_navy='\[\033[00;34m\]'
rgb_blue='\[\033[01;34m\]'
rgb_purple='\[\033[00;35m\]'
rgb_magenta='\[\033[01;35m\]'
rgb_cadet='\[\033[00;36m\]'
rgb_cyan='\[\033[01;36m\]'
rgb_gray='\[\033[00;37m\]'
rgb_white='\[\033[01;37m\]'

rgb_std="${rgb_white}"

if [ `id -u` -eq 0 ]
then
    rgb_usr="${rgb_red}"
else
    rgb_usr="${rgb_green}"
fi

[ -n "$PS1" ] && PS1="${rgb_usr}`whoami`${rgb_std}@\h \W${rgb_usr} \$(if [[ \$? == 0 ]]; then echo \"${rgb_forest}:)\"; else echo \"${rgb_red}:(\"; fi)${rgb_usr} :${rgb_restore} "

unset   rgb_restore   \
        rgb_black     \
        rgb_firebrick \
        rgb_red       \
        rgb_forest    \
        rgb_green     \
        rgb_brown     \
        rgb_yellow    \
        rgb_navy      \
        rgb_blue      \
        rgb_purple    \
        rgb_magenta   \
        rgb_cadet     \
        rgb_cyan      \
        rgb_gray      \
        rgb_white     \
        rgb_std       \
        rgb_usr


########################
#       exports        #
########################
export http_proxy="http://internetproxy-id.swisslife-select.de:3128"
#wpa_supplicant -i wlp3s0 -c /etc/wlan-cfg/wpa-work.conf
#dhcpd wlp3s0

###################
#    Scripting    #
###################
swps(){
  if [ $# -eq 1 ] ; then
    if [ `id -u` -eq 0 ] ; then
      case $1 in
        l)  PS1="\[\033[01;31m\]`whoami`\[\033[01;37m\]@\h \w\[\033[01;31m\]:\[\033[00m\] " ;;
        s)  PS1="\[\033[01;31m\]`whoami`\[\033[01;37m\]@\h \W\[\033[01;31m\]:\[\033[00m\] " ;;
        *)  echo "Please use l (for long) or s (for short)"
      esac
    else
      case $1 in
        l)  PS1="\[\033[01;32m\]`whoami`\[\033[01;37m\]@\h \w\[\033[01;32m\]:\[\033[00m\] " ;;
        s)  PS1="\[\033[01;32m\]`whoami`\[\033[01;37m\]@\h \W\[\033[01;32m\]:\[\033[00m\] " ;;
        *)  echo "Please use l (for long) or s (for short)"
      esac
    fi
  else
    echo "Usage: swps arg"
    echo "       l for long Path"
    echo "       s for short Path"
  fi
}

#Extract things. Thanks to urukrama, Ubuntuforums.org	
extract () {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1        ;;
             *.tar.gz)    tar xzf $1     ;;
             *.bz2)       bunzip2 $1       ;;
             *.rar)       rar x $1     ;;
             *.gz)        gunzip $1     ;;
             *.tar)       tar xf $1        ;;
             *.tbz2)      tar xjf $1      ;;
             *.tgz)       tar xzf $1       ;;
             *.zip)       unzip $1     ;;
             *.Z)         uncompress $1  ;;
             *.7z)        7z x $1    ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

#netinfo - shows network information for your system
netinfo ()
{
	echo "-- Network -------------------------------"
	/usr/bin/ifconfig | grep --word-regexp inet | awk '{print $2}'
	#/sbin/ifconfig | awk /'inet/ {print $2}'
	#ip addr show | awk '$1 == "inet" {gsub(/\/.*$/, "", $2); print $2}'	
	/sbin/ifconfig | awk /'broadcast/ {print $3}'
	/sbin/ifconfig | awk /'inet/ {print $4}'
	/sbin/ifconfig | awk /'ether/ {print $2}'
	echo "------------------------------------------"
}

hwinfo ()
{
  echo "-- Hardware ------------------------------"
  echo "|    Architecture: "`uname -smr | awk '{print $3}'`
  echo "|    CPU Model: "`grep "model name" /proc/cpuinfo | awk 'NR==1{print $4,$5,$7}'`
  echo "|    CPUs: "`lscpu | awk '$1 == "CPU(s):" {print $2}'`
  echo "|    RAM: "`free -h | awk '/Mem/ {print $2}'`
  echo "------------------------------------------"
}

osinfo ()
{
  echo "-- Operating System ----------------------"
  echo "|    OS: " `uname -a | awk '{print $6}';uname -smr | awk '{print $1}'`
#  echo "|    Release: "`cat /etc/debian_version`
  echo "|    Kernel: "`uname -smr | awk '{print $2}'`
  echo "|    Hostname: "`hostname`
  echo "------------------------------------------"

}

dirsize ()
{
	du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
	egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
	egrep '^ *[0-9.]*M' /tmp/list
	egrep '^ *[0-9.]*G' /tmp/list
	rm -rf /tmp/list
} 

wlan ()
{
wlan=""
    if [ $# -eq 1 ] ; then
         case $1 in
             home)     wlan="/etc/wlan-cfg/wpa-home.conf"            ;;
             work)     wlan="/etc/wlan-cfg/wpa-work.conf"            ;;
             handy)    wlan="/etc/wlan-cfg/wpa-handy.conf"           ;;
             exit)     sudo pkill wpa && sudo pkill dhcpcd; return 0 ;;
             *)        echo "'$1' is not configured";return 1        ;;
         esac
         sudo wpa_supplicant -i wlp3s0 -c $wlan -B
         sleep 4
         sudo dhcpcd wlp3s0
     else
         echo "Please give an configured WLAN"
     fi
}


######################
#   WELCOME SCREEN   #
######################

clear
#echo -e "Kernel Information: " `uname -smr`;
#echo -ne "Hello $USER today is "; date
#echo -e "${WHITE}"; cal ; echo "";
echo -ne "${GREEN}";hwinfo;
echo ""
echo -ne "${GREEN}";osinfo;
echo ""
echo -ne "${GREEN}";netinfo;
#echo -ne "${LIGHTBLUE}Uptime for this computer is ";uptime | awk /'up/ {print $3,$4}'
echo ""; echo ""
