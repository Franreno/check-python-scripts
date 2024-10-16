#!/bin/bash

# Function to check if Python 3 is installed and in the PATH
check_python() {
    if command -v python3 &>/dev/null; then
        echo "Python 3 is installed."
    else
        echo "Python 3 is not installed. Attempting to install..."
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            sudo apt update && sudo apt install -y python3
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            brew install python3
        fi
    fi
}

# Function to check if pip or pip3 is installed and in the PATH
check_pip() {
    if command -v pip &>/dev/null; then
        echo "pip is installed."
    elif command -v pip3 &>/dev/null; then
        echo "pip3 is installed."
    else
        echo "Neither pip nor pip3 is installed. Attempting to install..."
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            # For Debian-based systems
            if command -v apt &>/dev/null; then
                echo "Using apt to install pip3..."
                sudo apt update && sudo apt install -y python3-pip
            else
                echo "Apt package manager not found. Please install pip manually."
                exit 1
            fi
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            python3 -m ensurepip --upgrade || python3 -m pip install --upgrade pip
        fi
    fi
}

# Function to verify if packages can be installed
check_package_installation() {
    echo "Verifying if pip can install packages..."
    if pip install requests || pip3 install requests; then
        echo "Package installation works!"
    else
        echo "Package installation failed. Attempting to fix..."
        python3 -m pip install --upgrade pip
        pip install requests || pip3 install requests
    fi
}

# Main script execution
check_python
check_pip
check_package_installation

echo "Check completed."
