#!/bin/bash
# setup_vm.sh - Configure GCP VM for OpenClaw ASO

echo "Updating system..."
sudo apt-get update && sudo apt-get upgrade -y

echo "Installing Node.js and npm..."
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "Installing Playwright dependencies..."
sudo npx playwright install-deps

echo "Installing OpenClaw CLI..."
npm install -g @openclaw/cli

echo "Cloning ASO repository..."
# THE USER WILL NEED TO PROVIDE THE REPO URL
# git clone <REPO_URL> aso
# cd aso

echo "Setting up environment variables..."
# echo "export GEMINI_API_KEY=<YOUR_KEY>" >> ~/.bashrc
# source ~/.bashrc

echo "Setup complete. Run 'openclaw team start openclaw-team.yaml' to begin."
