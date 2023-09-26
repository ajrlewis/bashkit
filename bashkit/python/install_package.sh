#!/usr/bin/env bash

# Install script for a Python project

# Ensure that the virtual environment is deleted before recreating it
if [ -d venv ]; then
    echo "Deleting existing virtual environment..."
    rm -Rf venv
fi

# Specify the required Python version
PYTHON_VERSION=3.11

# Create a virtual environment for the project
echo "Creating virtual environment..."
python${PYTHON_VERSION} -m venv venv || { echo "Unable to create virtual environment."; exit 1; }

# Activate the virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Upgrade pip to the latest version
echo "Upgrading pip..."
pip install --upgrade pip || { echo "Unable to upgrade pip."; exit 1; }

# Install the project dependencies from requirements.txt
if [ -f requirements.txt ]; then
    echo "Installing project dependencies..."
    pip install -r requirements.txt --no-cache-dir || { echo "Unable to install project dependencies."; exit 1; }
else
    echo "requirements.txt not found; skipping dependency installation."
fi

# Deactivate the virtual environment
echo "Deactivating virtual environment..."
deactivate
