
wal -n -i ~/.colorscheme.jpg &>/dev/null
set fish_greeting

set PATH $HOME/App/flutter/bin $PATH $HOME/Scripts $HOME/.local/bin $HOME/.cargo/bin $HOME/.local/share/gem/ruby/3.3.0/bin 
set XDG_CONFIG_HOME $HOME/.config
set XDG_CONFIG_DIRS $HOME/.config
set XDG_CURRENT_DESKTOP "dwm"
set MANPAGER "nvim +Man!"

alias sdwm "startx /usr/local/bin/dwm"
alias untar "tar -xvf"
alias pinit "pwninit --template-path ~/Scripts/pwninittemplate.py"
alias sshpwn "ssh -i ~/.ssh/key hacker@pwn.college"
alias rgjia "rg -j 32 -ia"
alias runpwn "sudo ~/App/pwn2404/run.sh"

fish_add_path -a /home/sandor/.foundry/bin
