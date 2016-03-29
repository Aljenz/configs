# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jens/.zshrc'

autoload -Uz compinit
compinit

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


########################
#       exports        #
########################
#wpa_supplicant -i wlp3s0 -c /etc/wlan-cfg/wpa-work.conf
#dhcpd wlp3s0

###################
#    Scripting    #
###################
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
  echo "|    RAM: "`free -h | awk '/Speicher/ {print $2}'`
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
         echo "Please give an configured WLAN";return 1
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


# freak
