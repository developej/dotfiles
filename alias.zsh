# aliases
# push and pop directories on directory stack
alias pu="pushd"
alias po="popd"

# basic directory operations
alias ...="cd ../.."
alias -- -="cd -"
alias rm="rm -i"
alias lock="i3lock -i /storage/Dropbox/Public/wallpapers/HAL_eye_2560x1440.png"

# show history
alias history="fc -l 1"

# list all
alias l="ls -alh"
# count all
alias countall="ls | wc -l"
# list files
alias lf="ls -alh | grep ^-"
# count files
alias countfiles="ls -l | grep ^- | wc -l"
# list directories
alias ld="ls -alh | grep ^d"
# count directories
alias countdirs="ls -l | grep ^d | wc -l"
# list symbolic links
alias ll="ls -alh | grep ^l"
# count symbolic links
alias countsymlinks="ls -l | grep ^l | wc -l"

# pacman aliases
alias syu="sudo pacman -Syu"
alias asyu="yaourt -Sbu --aur"
# system aliases
alias sshn="sudo shutdown -h now"
alias sr="sudo reboot"
