#!/bin/bash
# Author: Ravi Joshi
# Date: 30 Apr 2025

# Exit immediately if a command exits with a non-zero status
set -e

# Logging function with timestamp and level
log() {
    local level="${2:-INFO}"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $1"
}

# Function to configure the 'll' alias system-wide
setup_aliases() {
    local bashrc="/etc/bash.bashrc"
    local alias_line="alias ll='ls -alF'"

    if ! grep -Fxq "$alias_line" "$bashrc"; then
        log "Adding 'll' alias to $bashrc"
        echo "$alias_line" | sudo tee -a "$bashrc" > /dev/null
    else
        log "Alias 'll' already exists in $bashrc"
    fi
}

# Function to ensure a bash history file exists
setup_bash_history() {
    local histfile="${HISTFILE:-$HOME/.bash_history}"

    if [ ! -f "$histfile" ]; then
        log "Creating bash history file at $histfile"
        touch "$histfile"
        chmod 600 "$histfile"
    else
        log "Bash history file already exists at $histfile"
    fi
}

# Function to configure ROS environment
setup_ros() {
    log "Setting up ROS environment..."

    if [ -z "${ROS_DISTRO:-}" ]; then
        log "ROS_DISTRO environment variable is not set." "ERROR"
        exit 1
    fi

    # Initialize dependencies
    if ! sudo rosdep init 2>/dev/null; then
        log "rosdep already initialized, skipping."
    else
        rosdep update --include-eol-distros
    fi
    # rosdep install --from-paths src --ignore-src -y
    sudo chown -R "$(whoami)" /home/ros

    log "ROS environment setup completed."
}

# Entry point
main() {
    log "Starting setup process..."
    setup_aliases
    setup_bash_history
    setup_ros
    log "All setup steps completed successfully."
}

# Source ROS
source "/opt/ros/$ROS_DISTRO/setup.bash"
    
main "$@"
