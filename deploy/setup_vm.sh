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

GITHUB_URL="https://github.com/BigBrown10/dundundun"
GEMINI_API_KEY=$API_KEY
echo "Configuration verified."

echo "Cleaning up old Node.js repositories..."
sudo rm -f /etc/apt/sources.list.d/nodesource.list
sudo apt-get update

echo "Updating system..."
sudo apt-get upgrade -y

echo "Installing Git..."
sudo apt-get install -y git

echo "Installing Node.js and npm (Version 22)..."
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verify Node version
NODE_VER=$(node -v)
echo "Installed Node version: $NODE_VER"

echo "Installing Playwright dependencies..."
sudo npx playwright install-deps

echo "Installing OpenClaw CLI..."
sudo npm install -g openclaw@latest

echo "Cloning ASO repository..."
# Cleanup old attempts
rm -rf aso dundundun
git clone "$GITHUB_URL" aso
cd aso

echo "Setting up environment variables..."
# Prevent duplicates in .bashrc
grep -q "GEMINI_API_KEY" ~/.bashrc || echo "export GEMINI_API_KEY=$GEMINI_API_KEY" >> ~/.bashrc
export GEMINI_API_KEY=$GEMINI_API_KEY

echo "------------------------------------------------"
echo "Setup complete! Node version: $(node -v)"
echo "Next steps:"
echo "1. source ~/.bashrc"
echo "2. cd aso"
echo "3. openclaw team start openclaw-team.yaml"
echo "------------------------------------------------"
