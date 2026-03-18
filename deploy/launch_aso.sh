#!/bin/bash
# launch_aso.sh - Native OpenClaw Activation for ASO

echo "🚀 Initializing Autonomous Sales Orchestrator..."

# 1. Configure Gateway Token persistently
TOKEN="aso_secure_token_2026"
export OPENCLAW_GATEWAY_TOKEN="$TOKEN"

# Add to .bashrc if not already there
if ! grep -q "OPENCLAW_GATEWAY_TOKEN" ~/.bashrc; then
    echo "export OPENCLAW_GATEWAY_TOKEN=\"$TOKEN\"" >> ~/.bashrc
    echo "Added token to ~/.bashrc"
fi

echo "[1/3] Starting OpenClaw Gateway..."
# Force stop and restart to ensure the token is applied
openclaw gateway stop > /dev/null 2>&1
openclaw gateway start --token "$TOKEN" --force
sleep 5

# Verify health
if ! openclaw health > /dev/null 2>&1; then
    echo "❌ Gateway failed to start. Please check 'openclaw gateway status'"
    exit 1
fi

# 2. Add the specialized agents
echo "[2/3] Registering Sales Team agents..."

# Try adding agents with the simplest possible syntax
# If --model is rejected, we will configure it later via config set
openclaw agents add Atlas
openclaw agents add Librarian
openclaw agents add Momus
openclaw agents add Sisyphus
openclaw agents add Hephaestus

# 3. Final Verification
echo "[3/3] Verifying team status..."
openclaw agents list

echo "------------------------------------------------"
echo "Mission Ready! Your agents are now live."
echo "------------------------------------------------"
echo "Next steps:"
echo "1. source ~/.bashrc"
echo "2. openclaw tui"
echo "------------------------------------------------"
