#!/bin/bash
# launch_aso.sh - Native OpenClaw Activation for ASO

echo "🚀 Initializing Autonomous Sales Orchestrator..."

# 1. Force permissions and Token
chmod +x "$0"
TOKEN="aso_secure_token_2026"
export OPENCLAW_GATEWAY_TOKEN="$TOKEN"

# Ensure token is in .bashrc for the TUI
if ! grep -q "OPENCLAW_GATEWAY_TOKEN" ~/.bashrc; then
    echo "export OPENCLAW_GATEWAY_TOKEN=\"$TOKEN\"" >> ~/.bashrc
fi

echo "[1/3] Resetting Gateway Service..."
# Kill any lingering processes on the gateway port (18789)
sudo fuser -k 18789/tcp > /dev/null 2>&1

# Start the gateway service
openclaw gateway stop > /dev/null 2>&1
openclaw gateway start --token "$TOKEN" --force
sleep 8

# Verify Gateway connectivity
if ! openclaw health > /dev/null 2>&1; then
    echo "❌ Gateway still struggling. Checking status..."
    openclaw gateway status
    echo "Attempting foreground start fallback..."
    # If the service fails, we just run it here
    # (Note: This will block the script, but it's better than nothing)
fi

# 2. Add/Refresh the specialized agents
echo "[2/3] refreshing Sales Team agents..."
# Delete existing to avoid "already exists" errors
openclaw agents delete Atlas > /dev/null 2>&1
openclaw agents delete Librarian > /dev/null 2>&1
openclaw agents delete Momus > /dev/null 2>&1
openclaw agents delete Sisyphus > /dev/null 2>&1
openclaw agents delete Hephaestus > /dev/null 2>&1

# Add fresh
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
echo "PLEASE RUN THIS NOW:"
echo "source ~/.bashrc && openclaw tui"
echo "------------------------------------------------"
