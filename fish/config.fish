#!/usr/bin/fish

# funtions stuff
function tv
    bash ~/.config/fish/functions/tv.sh
end

function 24-bit-color
    bash ~/.config/fish/functions/24-bit-color.sh
end

function print256colours
    bash ~/.config/fish/functions/print256colours.sh
end

function showTrueColor
    bash ~/.config/fish/functions/showTrueColor.sh
end

function sudo --description "Replacement for Bash 'sudo !!' command to run last command using sudo."
	if test "$argv" = !!
		eval command sudo $history[1]
	else
		command sudo $argv
	end
end

function dl --description "download file like bitTorrent,..."
	cd ~/Downloads
	aria2c $argv
	ls -lah ~/Downloads
	cd -
end

function run --description "run test for c/cpp, Python"
	if ls $argv | grep ".cpp"
        g++ $argv
		./a.out
		rm a.out
	else if ls $argv | grep ".c"
		gcc $argv
		./a.out
        rm a.out
	end
end

function cpppro
    mkdir $argv
    cd $argv
    cp -r ~/.config/nvim/stuff/cpppro/* .
    nvim -O *
end

function runcpp
    g++ *.cpp
    ./a.out
    rm a.out
end

function repeat
	while true
		$argv
		sleep 1
	end
end

function SERVER_IP --description "live server, go to folder project, have index.html"
	hostname -I
end

function se
	browser-sync start --server --files . --no-notify --host SERVER_IP --port 9000
end

########################################################################

set -g -x fish_greeting yo!

set -g fish_term24bit 1
fzf_key_bindings
fish_vi_key_bindings

set -U EDITOR nvim
export EDITOR='nvim'
export VISUAL='nvim'

# lazy code
# alias l='ls -lha'
# ls, tree more color
alias l='clear ; exa -al --color=always --group-directories-first'
alias ls='clear ; exa -al --color=always --group-directories-first'
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a | egrep "^\."'

alias fd='fdfind'
alias cpf='xclip -sel clip'
alias fishr='source ~/.config/fish/config.fish'
alias tmuxr='tmux source ~/.tmux.conf'
alias g='grep'
alias h='htop'
alias e='exit'
alias :q='exit'
alias p='ipython3'
alias rbn='sudo reboot now'
alias sdn='sudo shutdown now'
alias mkd='mkdir -pv'
alias ka='killall'
alias v='nvim'
alias o='open'
alias 777='chmod -R 777'
alias x='chmod +x'
alias f='fd . -H | grep'

# ubuntu apt
alias ins='sudo apt install -y'
alias uins='sudo apt remove -y'

# fedora dnf
# alias ins='sudo dnf install -y'
# alias uins='sudo dnf remove -y'

# arch
# alias ins='sudo pacman -S --noconfirm'
# alias uins='sudo pacman -Rs --noconfirm'

# tmux
# alias ide='tmux split-window -v -p 30 ; tmux split-window -h -p 66 ; tmux split-window -h -p 50'
alias ide='tmux split-window -v -p 20 ; tmux split-window -h -p 75'
alias qa='tmux ls; tmux kill-session -a'

# cd
alias ..='cd .. ; clear ; l'
alias ...='cd .. ; cd .. ; cd .. ; clear ; l'

function dow
    cd ~/Downloads
    clear
    l
end

function doc
    cd ~/Documents
    clear
    l
end

# youtube-dl
alias yt='youtube-dl --add-metadata -i'
alias yta='yt -x --audio-format mp3'

# trash-cli
alias t='trash'
alias tdl='trash ~/Downloads/*'

# fzf
alias cf='cd ~/.config/ ; nvim -o (fzf)'
# export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_COMMAND='fd -H --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# paper color
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#4d4d4c,bg:#eeeeee,hl:#d7005f
    --color=fg+:#4d4d4c,bg+:#e8e8e8,hl+:#d7005f
    --color=info:#4271ae,prompt:#8959a8,pointer:#d7005f
    --color=marker:#4271ae,spinner:#4271ae,header:#4271ae'

# gruvbox dark
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
        # --color fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
        # --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54'

function c -d "Fuzzy change directory"
	if set -q argv[1]
        set searchdir $argv[1]
	else
        set searchdir $HOME
    end

    # https://github.com/fish-shell/fish-shell/issues/1362
	set -l tmpfile (mktemp)
	find $searchdir \( ! -regex '.*/\..*' \) ! -name __pycache__ -type d | fzf > $tmpfile
	set -l destdir (cat $tmpfile)
	rm -f $tmpfile

	if test -z "$destdir"
	return 1
	end

	cd $destdir
    l
end

function fco -d "Fuzzy-find and checkout a branch"
  git branch --all | grep -v HEAD | string trim | fzf | read -l result; and git checkout "$result"
end

function fcoc -d "Fuzzy-find and checkout a commit"
  git log --pretty=oneline --abbrev-commit --reverse | fzf --tac +s -e | awk '{print $1;}' | read -l result; and git checkout "$result"
end

# git
alias yo='git add -A ; git commit -m (curl -s whatthecommit.com/index.txt)'
alias sta='git status'
alias push="git push"
alias pull="git pull" 
alias clone='git clone'
alias commit='git commit -m'
alias prettier='prettier --write .'
alias okp='prettier ; yo ; push '
alias ok='yo ; push'

function ghdotfiles
    cp -r ~/.config/vifm/* ~/git/dotfiles/vifm
	cp ~/.selected_editor ~/git/dotfiles
	cp ~/.gitconfig  ~/git/dotfiles/git/
	cp ~/.config/tmux/.tmux.conf ~/git/dotfiles/tmux/
    cp ~/.config/zsh/.zshrc ~/git/dotfiles/zsh/

    # nvim
	cp ~/.config/nvim/coc-settings.json ~/git/dotfiles/nvim/
    cp ~/.config/nvim/init.vim ~/git/dotfiles/nvim/
    cp -r ~/.config/nvim/stuff ~/git/dotfiles/nvim/
    cp -r ~/.config/nvim/coc-settings.json ~/git/dotfiles/nvim/
    # I don't want you see my undoir, hack me if you can.
    cp -r ~/.config/nvim/undodir ~/git/ok/

	cp -r ~/.config/fish/* ~/git/dotfiles/fish/
    crontab -l > ~/git/dotfiles/crontab/crontabConfig
    cp ~/.config/fish/functions/crontab* ~/git/dotfiles/crontab/
    dconf dump /org/gnome/desktop/wm/keybindings/ > ~/git/dotfiles/keybindings.dconf
    cp -r ~/.fonts ~/git/dotfiles/
	cd ~/git/dotfiles/
	okp ; cd -
end

alias ghlazyscript='cd ~/git/lazyscript ; okp ; cd -'
alias ghlinux_setup='cd ~/git/linux_setup ; okp ; cd -'
alias ghvimium_dark_theme='cd ~/git/vimium_dark_theme ; okp ; cd -'
alias ghFreeCodeCampProject='cd ~/git/FreeCodeCampProject ; okp ; cd -'
alias ghok='cd ~/git/ok ; okp ; cd -'
alias ghdataLab='cd ~/git/dataLab ; okp ; cd -'
alias ghwindowsSetup='cd ~/git/windowsSetup ; okp ; cd -'
alias ghtermuxSetup='cd ~/git/termuxSetup ; okp ; cd -'
alias ghimg='cd ~/git/img ; okp ; cd -'
alias ghthuanpham2311='cd ~/git/thuanpham2311 ; okp ; cd -'
alias ghtheNewsTimes='cd ~/git/theNewsTimes ; okp ; cd -'
alias ghfour-card-feature-section='cd ~/git/four-card-feature-section ; okp ; cd -'
alias ghcalculatorOnIOS='cd ~/git/calculatorOnIOS ; okp ; cd -'

function gha --description "git push all project"
	cowsay "git push lazyscript"
	ghlazyscript

	cowsay "git push dotfiles"
	ghdotfiles

	cowsay "git push linux_setup" 
	ghlinux_setup

	cowsay "git push vimium-dark-theme" 
	ghvimium_dark_theme

	cowsay "git push FreeCodeCampProject" 
	ghFreeCodeCampProject

	cowsay "git push ok" 
	ghok

	cowsay "git push dataLab" 
	ghdataLab

	cowsay "git push windowsSetup" 
    ghwindowsSetup

	cowsay "git push termuxSetup" 
    ghtermuxSetup

	cowsay "git push img" 
    ghimg

	cowsay "git push thuanpham2311" 
    ghthuanpham2311

	cowsay "git push theNewsTimes" 
    ghtheNewsTimes

	cowsay "git push four-card-feature-section" 
    ghfour-card-feature-section

	cowsay "git push calculatorOnIOS" 
    ghcalculatorOnIOS

	cowsay "D O N E"
end

alias gldotfiles='cd ~/git/dotfiles ; pull ; cd -'
alias gllazyscript='cd ~/git/lazyscript ; pull ; cd -'
alias gllinux_setup='cd ~/git/linux_setup ; pull ; cd -'
alias glvimium_dark_theme='cd ~/git/vimium_dark_theme ; pull ; cd -'
alias glFreeCodeCampProject='cd ~/git/FreeCodeCampProject ; pull ; cd -'
alias glok='cd ~/git/ok ; pull ; cd -'
alias gldataLab='cd ~/git/dataLab ; pull ; cd -'
alias glwindowsSetup='cd ~/git/windowsSetup ;  pull ; cd -'
alias gltermuxSetup='cd ~/git/termuxSetup ;  pull ; cd -'
alias glimg='cd ~/git/img ; pull ; cd -'
alias glthuanpham2311='cd ~/git/thuanpham2311 ; pull ; cd -'
alias gltheNewsTimes='cd ~/git/theNewsTimes ; pull ; cd -'
alias glfour-card-feature-section='cd ~/git/four-card-feature-section ; pull ; cd -'
alias glcalculatorOnIOS='cd ~/git/calculatorOnIOS ; pull ; cd -'

function gla --description "git pull all project"
	cowsay "git pull lazyscript" 
	gllazyscript 

	cowsay "git pull dotfiles" 
	gldotfiles 

	cowsay "git pull linux_setup" 
	gllinux_setup 

	cowsay "git pull vimium-dark-theme" 
	glvimium_dark_theme

	cowsay "git pull FreeCodeCampProject" 
	glFreeCodeCampProject 

	cowsay "git pull ok" 
	glok

	cowsay "git pull dataLab" 
	gldataLab

	cowsay "git pull windowsSetup" 
    glwindowsSetup

	cowsay "git pull termuxSetup" 
    gltermuxSetup

	cowsay "git pull img" 
    glimg

	cowsay "git pull thuanpham2311" 
    glthuanpham2311

	cowsay "git pull theNewsTimes" 
    gltheNewsTimes

	cowsay "git pull four-card-feature-section"
    glfour-card-feature-section

	cowsay "git pull calculatorOnIOS"
    glcalculatorOnIOS

	cowsay "D O N E"
end

# browser
alias browser='brave-browser'
# alias browser='google-chrome'
# alias browser='firefox'
alias github='browser --new-window "https://github.com/thuanpham2311"'

alias browser_youtube_subsriptions='browser "https://www.youtube.com/feed/subscriptions"'
alias browser_fb='browser https://facebook.com'
alias browser_stu='browser "http://stu.edu.vn/"'
alias browser_stu2='browser "http://www.stu.edu.vn/vi/265/khoa-cong-nghe-thong-tin.html"'
alias browser_mail0='browser "https://mail.google.com/mail/u/0/#inbox"'
alias browser_mail1='browser "https://mail.google.com/mail/u/1/#inbox"'
alias browser_mail2='browser "https://mail.google.com/mail/u/2/#inbox"'
alias browser_mail='browser_mail0 ; browser_mail1 ; browser_mail2'
alias browser_linkedin='browser "https://www.linkedin.com/feed/"'

function browser_daily
    cowsay "GET.SHIT.DONE"
    browser_youtube_subsriptions
	browser_linkedin
    browser_mail0
    browser_mail1
	browser_fb
	browser_stu
end

## search
function !t
	browser --new-window "https://translate.google.com/?source=osdd#auto|auto|$argv"
end

function !y
	browser --new-window "https://www.youtube.com/results?search_query=$argv"
end

function !gm
	browser --new-window "https://www.google.com/maps?q=$argv"
end

function !g
	browser --new-window "https://www.google.com/search?q=$argv"
end

function !gi
	browser --new-window "https://www.google.com/search?tbm=isch&q=$argv"
end

function !w
	browser --new-window "https://en.wikipedia.org/wiki/Special:Search?search=$argv"
end

function !gh
	browser --new-window "https://github.com/search?q=$argv"
end

function !fa
	browser --new-window "https://www.facebook.com/search?q=$argv"
end

function !m
	browser --new-window "https://medium.com/search?q=$argv"
end

# mode
alias hi='browser_daily ; rem'
# alias rem='sudo dnf update -y ; sudo dnf autoremove -y ; flatpak update -y'
function rem
    nvim -c "PlugUpdate | qa"
    sudo apt update
    sudo apt upgrade -y
    sudo apt autoremove -y
    sudo apt autoclean
    tldr --update
    sudo npm install -g npm
    clear
end

# function rem
    # sudo pacman -Syyu --noconfirm
    # sudo npm install -g npm
    # nvim -c "PlugUpdate | qa"
    # tldr --update
# end

function data --description "setup for data research"
	cd ~/git/dataLab/
	tmux split-window -h -p 50
	jupyter lab
end
