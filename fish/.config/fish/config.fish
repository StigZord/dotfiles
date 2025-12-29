set -U fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -Ux SUDO_EDITOR nvim

# bun
export BUN_INSTALL="$HOME/.bun"
fish_add_path $BUN_INSTALL/bin

fish_add_path -U ~/.cargo/bin
fish_add_path -U ~/.local/share/bob/nvim-bin

alias vim='nvim'
alias vi='nvim'

# Tmux
abbr t tmux
abbr tc 'tmux attach'
abbr ta 'tmux attach -t'
abbr tad 'tmux attach -d -t'
abbr ts 'tmux new -s'
abbr tl 'tmux ls'
abbr tk 'tmux kill-session -t'
abbr mux tmuxinator

# Git
abbr gst 'git status'

zoxide init fish | source
starship init fish | source
