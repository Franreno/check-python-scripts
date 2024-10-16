# Function to check if Python 3 is installed and in the PATH
function Check-Python {
    if (Get-Command python3 -ErrorAction SilentlyContinue) {
        Write-Host "Python 3 is installed."
    } else {
        Write-Host "Python 3 is not installed. Attempting to install..."
        Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.10.0/python-3.10.0-amd64.exe" -OutFile "$env:TEMP\python-installer.exe"
        Start-Process -FilePath "$env:TEMP\python-installer.exe" -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
        Remove-Item "$env:TEMP\python-installer.exe"
    }
}

# Function to check if pip is installed and in the PATH
function Check-Pip {
    if (Get-Command pip3 -ErrorAction SilentlyContinue) {
        Write-Host "pip3 is installed."
    } else {
        Write-Host "pip3 is not installed. Attempting to install..."
        python3 -m ensurepip --upgrade
        python3 -m pip install --upgrade pip
    }
}

# Function to verify if packages can be installed
function Check-PackageInstallation {
    Write-Host "Verifying if pip can install packages..."
    try {
        pip3 install requests
        Write-Host "Package installation works!"
    } catch {
        Write-Host "Package installation failed. Attempting to fix..."
        python3 -m pip install --upgrade pip
        pip3 install requests
    }
}

# Main script execution
Check-Python
Check-Pip
Check-PackageInstallation

Write-Host "Check completed."
