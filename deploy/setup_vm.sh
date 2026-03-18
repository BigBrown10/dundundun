# setup_vm.sh - Configure GCP VM for OpenClaw ASO

# IMPORTANT: Do not hardcode sensitive keys here.
# Usage: ./setup_vm.sh [GEMINI_API_KEY]

# Use argument if provided, otherwise check env
API_KEY=${1:-$GEMINI_API_KEY}

if [ -z "$API_KEY" ]; then
    echo -n "Please enter your Gemini API Key (input will be hidden): "
    read -rs API_KEY
    echo ""
fi

echo "Verifying API Key..."
if [ -z "$API_KEY" ]; then
    echo "Error: Gemini API Key not found."
    exit 1
fi

GEMINI_API_KEY=$API_KEY
echo "API Key check passed."

echo "Updating system..."
sudo apt-get update && sudo apt-get upgrade -y

echo "Installing Git and Playwright dependencies..."
sudo apt-get install -y git
sudo npx playwright install-deps

echo "Installing Node.js and npm (Version 22)..."
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "Installing OpenClaw CLI..."
sudo npm install -g openclaw@latest

echo "Cloning ASO repository..."
# Cleanup old attempt if it exists
rm -rf dundundun
git clone "$GITHUB_URL"
cd dundundun

echo "Setting up environment variables..."
echo "export GEMINI_API_KEY=$GEMINI_API_KEY" >> ~/.bashrc
export GEMINI_API_KEY=$GEMINI_API_KEY

echo "Setup complete. Run 'openclaw team start openclaw-team.yaml' to begin."
