#!/bin/bash

# Tmux startup script with preconfigured sessions and windows

# Check if tmux is already running
if tmux has-session 2>/dev/null; then
    echo "Tmux sessions already exist. Attaching to existing session..."
    tmux attach
    exit 0
fi

# Session 0: notes
tmux new-session -d -s "notes" -c "~/notes" -n "terminal"
tmux send-keys -t "notes:terminal" "cd ~/notes" C-m

# Session 2: backend development
tmux new-session -d -s "backend" -c "~/dev/eletive/back-end/development" -n "terminal"
tmux send-keys -t "backend:terminal" "cd ~/dev/eletive/back-end/development" C-m

# Session 3: frontend development
tmux new-session -d -s "frontend" -c "~/dev/eletive/front-end/development" -n "terminal"
tmux send-keys -t "frontend:terminal" "cd ~/dev/eletive/front-end/development" C-m

# Session 3: configs
tmux new-session -d -s "configs" -c "~/drottfiles" -n "terminal"
tmux send-keys -t "configs:terminal" "cd ~/drottfiles" C-m

# Select the notes session by default
tmux select-window -t "notes:terminal"

# Attach to the notes session
tmux attach-session -t "notes"
