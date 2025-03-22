#!/usr/bin/zsh

export PATH="$PATH:/home/canela/git/WikiConfig/kali/Scripts"

alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias cls='clear'
alias vim='nvim'
alias spotify='spotify &'
alias pf='sudo'
alias pfv='sudo'
alias pls='sudo'
alias profile='nvim /home/retr0/.retr0.profile'
alias bit='qbittorrent &'
alias update='sudo apt update -y && sudo apt full-upgrade -y && flatpak update'
alias myip="dig +short canelasan.ddns.net"
alias myip2="curl http://ifconfig.me; echo"
alias sl='cd ~'
alias torb='torbrowser-launcher'
alias ltspice='wine ~/.wine/drive_c/Program\ Files/ADI/LTspice/LTspice.exe'
alias labrei='ssh canela@labrei.dsce.fee.unicamp.br -p 7531'
alias godot='. /home/canela/Softwares/Godot_v4.2.2-stable_linux.x86_64'
alias compartilhar='sudo systemctl restart smbd nmbd avahi-daemon'
alias bonjour='sudo systemctl restart smbd nmbd avahi-daemon'
alias delrecent='rm ~/.local/share/recently-used.xbel'
alias arquive='sudo sed -i "0,/browsable = no/s//browsable = yes/" /etc/samba/smb.conf'
alias unarquive='sudo sed -i "0,/browsable = yes/s//browsable = no/" /etc/samba/smb.conf'
alias tumb='sudo rm -rf ~/.cache/thumbnails/* && sudo nautilus -q && sudo nautilus &'
alias apaga='sudo shred -ufvz'
alias vera='sudo veracrypt --mount /dev/sda3 /mnt/Backup --filesystem=ext4'
alias backup='sudo rsync -avh --progress --delete --fuzzy'
alias vps='ssh ubuntu@rootretr0.serveftp.com'
