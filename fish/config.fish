#!/usr/bin/fish
set -g -x fish_greeting Hi, Nicholas 

fish_vi_key_bindings

function sudo --description "Replacement for Bash 'sudo !!' command to run last command using sudo."
	if test "$argv" = !!
		eval command sudo $history[1]
	else
		command sudo $argv
	end
end

###Lazy code### 
alias ..='cd ..'
alias ...='cd .. ; cd .. ; cd ..'
alias ....='cd .. ; cd .. ; cd .. ; cd ..'
alias c='clear'
alias h='history'
alias ins='sudo apt-get install -y'
alias uins='sudo apt-get remove -y'
alias e='exit'
alias v='nvim'
alias sv='sudo nvim'
alias t='touch'
alias l='ls -latr'
alias p='python3'
alias rem='sudo apt-get update ;sudo apt-get upgrade -y ;sudo apt-get autoremove -y;sudo apt-get autoclean ; sudo apt-get clean'
alias rbn='sudo reboot now'
alias sdn='sudo shutdown now'
###lazy code###

###git###
#commit so hard, so auto write commit cool 
alias clone='git clone'
alias yo='git add -A ; git commit -m (curl -s whatthecommit.com/index.txt)'
alias push="git push"
alias pull="git pull"

#location file saved on pc, code push on github saved at other folder, that's it 
alias ghdotfiles='cp ~/.tmux.conf ~/git/dotfiles/tmux ; cat ~/.config/nvim/init.vim > ~/.vimrc ; cp ~/.vimrc ~/git/dotfiles/vim ; cp ~/.config/nvim/init.vim ~/git/dotfiles/nvim ; cp ~/.bashrc ~/git/dotfiles/bash ; cp ~/.config/fish/config.fish ~/git/dotfiles/fish/ ; cd ~/git/dotfiles ; yo ; push'
alias ghfirstwebsite='cd ~/git/firstwebsite/ ; yo ; push'
alias ghpomodoro='cd ~/git/pomodoro/ ; yo ; push'

alias ghstudy='cd ~/git/study ; yo ; push'
alias gha='ghdotfiles ; ghstudy ; ghfirstwebsite ; ghpomodoro ; fortune | cowsay; cd'

alias gldotfiles='cd ~/git/dotfiles ; pull'
alias glstudy='cd ~/git/study ; pull'
alias glfirstwebsite='cd ~/git/firstwebsite ; pull'
alias glpomodoro='cd ~/git/pomodoro ; pull'
alias gla='gldotfiles ; glstudy ; glfirstwebsite ; glpomodoro ; cd ; cowthink -s "git pull all done"'
###git###

###firefox tab###
alias f='firefox'
alias ft='firefox -new-tab'
alias tab_youtube_subsriptions='ft "https://www.youtube.com/feed/subscriptions"'
alias tab_pocket='ft "https://app.getpocket.com/"'
alias tab_pomodoro='ft "https://youtu.be/1znjHDiqBk8?t=1"'
alias tab_github='ft https://github.com/nicholaspham2311'

alias tab_music_happy='ft "https://www.youtube.com/watch?v=ru0K8uYEZWw&list=RDQMDUPdPTv_LL4&start_radio=1"'
alias tab_music_anime='ft "https://www.youtube.com/watch?v=CaksNlNniis&list=PL8lZieNFgOdmrNGTqwjqYJpJ_2nw_O_M2"'
alias tab_music_chill='ft https://youtu.be/hHW1oY26kxQ'
alias tab_music_rapvn='ft "https://www.youtube.com/watch?v=r4Dypit7UCI&list=RDr4Dypit7UCI&start_radio=1"'

alias tab_anime='ft "https://www9.gogoanime.io/"'
alias tab_kdrama='ft "https://www.dramacool9.co/category/drama/?country=korean"'
alias tab_kmovie='ft "https://ww1.fmovies.to/country/korea"'
alias tab_fun='tab_anime ; tab_kdrama ; tab_kmovie'

alias tab_toidicodedao='ft "https://toidicodedao.com/"'
alias tab_thefullsnack='ft "https://thefullsnack.com/"'
alias tab_codeaholicguy='ft "https://codeaholicguy.com/"'
alias tab_thai='ft "https://vnhacker.blogspot.com/"'
alias tab_blogs='tab_toidicodedao ; tab_thefullsnack ; tab_codeaholicguy ; tab_thai'
###fire tab###

###mode###
alias work='cowthink -s "." ; tab_music_chill ; tab_pomodoro ; gla ; gha'
alias hola='cowthink -s "hola hola" ; tab_fun ; tab_youtube_subsriptions ; tab_blogs ; tab_pocket ; tab_music_rapvn ; rem ; gla ; gha'
###mode###
