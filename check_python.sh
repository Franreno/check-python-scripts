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

# Function to check if pip3 is installed and in the PATH
check_pip() {
    if command -v pip3 &>/dev/null; then
        echo "pip3 is installed."
    else
        echo "pip3 is not installed. Attempting to install..."
        python3 -m ensurepip --upgrade || python3 -m pip install --upgrade pip
    fi
}

# Function to verify if packages can be installed
check_package_installation() {
    echo "Verifying if pip can install packages..."
    if pip3 install requests; then
        echo "Package installation works!"
    else
        echo "Package installation failed. Attempting to fix..."
        python3 -m pip install --upgrade pip
        pip3 install requests
    fi
}

# Main script execution
check_python
check_pip
check_package_installation

echo "Check completed."
