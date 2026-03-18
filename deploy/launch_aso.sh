#!/bin/bash
# launch_aso.sh - Native OpenClaw Activation for ASO

echo "🚀 Initializing Autonomous Sales Orchestrator..."

# 1. Start the Gateway with a fixed token for the TUI
export OPENCLAW_GATEWAY_TOKEN="aso_secure_token_2026"

if ! openclaw health > /dev/null 2>&1; then
    echo "[1/3] Starting OpenClaw Gateway..."
    # Force stop any existing gateway to apply the new token
    openclaw gateway stop > /dev/null 2>&1
    openclaw gateway start --token "$OPENCLAW_GATEWAY_TOKEN"
    sleep 5
fi

# 2. Add the specialized agents
echo "[2/3] Registering Sales Team agents..."

# Positional name, then flags
openclaw agents add Atlas --model gemini-3.1-flash
openclaw agents add Librarian --model gemini-3.1-flash
openclaw agents add Momus --model gemini-3.1-flash
openclaw agents add Sisyphus --model gemini-3.1-flash
openclaw agents add Hephaestus --model gemini-1.5-flash

# 3. Final Verification
echo "[3/3] Verifying team status..."
openclaw agents list

echo "------------------------------------------------"
echo "Mission Ready! Your agents are now live."
echo "You can now message your agents via the TUI or your connected channels."
echo "Try: openclaw tui"
echo "------------------------------------------------"
