#!/bin/bash
# setup_vm.sh - Configure GCP VM for OpenClaw ASO

PROJECT_ID="gen-lang-client-0363688150"
GITHUB_URL="https://github.com/BigBrown10/dundundun"
GEMINI_API_KEY="AIzaSyBE3-JkEqfFmMgk6vxSURZeL5xyFsk_voM"

echo "Updating system..."
sudo apt-get update && sudo apt-get upgrade -y

echo "Installing Node.js and npm..."
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "Installing Playwright dependencies..."
sudo npx playwright install-deps

echo "Installing OpenClaw CLI..."
sudo npm install -g @openclaw/cli

echo "Cloning ASO repository..."
git clone $GITHUB_URL aso
cd aso

echo "Setting up environment variables..."
echo "export GEMINI_API_KEY=$GEMINI_API_KEY" >> ~/.bashrc
export GEMINI_API_KEY=$GEMINI_API_KEY

echo "Setup complete. Run 'openclaw team start openclaw-team.yaml' to begin."
