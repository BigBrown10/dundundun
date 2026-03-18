# setup_vm.sh - Configure GCP VM for OpenClaw ASO

# IMPORTANT: Do not hardcode sensitive keys here.
# Usage: ./setup_vm.sh [GEMINI_API_KEY]

# Use argument if provided, otherwise check env
API_KEY=${1:-$GEMINI_API_KEY}

echo "Verifying API Key..."
if [ -z "$API_KEY" ]; then
    echo "Error: Gemini API Key not found."
    echo "Please run: ./setup_vm.sh AIzaSyB..."
    exit 1
fi

GEMINI_API_KEY=$API_KEY
echo "API Key check passed."

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
