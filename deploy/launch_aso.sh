#!/bin/bash
# launch_aso.sh - Native OpenClaw Activation for ASO

echo "🚀 Initializing Autonomous Sales Orchestrator..."

# 1. Start the Gateway in the background if not running
if ! openclaw health > /dev/null 2>&1; then
    echo "[1/3] Starting OpenClaw Gateway..."
    openclaw gateway start
    sleep 5
fi

# 2. Add the specialized agents
echo "[2/3] Registering Sales Team agents..."

# Atlas - Orchestrator
openclaw agents add --name Atlas --role Orchestrator --model gemini-3.1-flash
# Librarian - Researcher
openclaw agents add --name Librarian --role Researcher --model gemini-3.1-flash
# Momus - Analyst
openclaw agents add --name Momus --role Analyst --model gemini-3.1-flash
# Sisyphus - Closer
openclaw agents add --name Sisyphus --role Closer --model gemini-3.1-flash
# Hephaestus - Ops
openclaw agents add --name Hephaestus --role "Sales Ops" --model gemini-1.5-flash

# 3. Final Verification
echo "[3/3] Verifying team status..."
openclaw agents list

echo "------------------------------------------------"
echo "Mission Ready! Your agents are now live."
echo "You can now message your agents via the TUI or your connected channels."
echo "Try: openclaw tui"
echo "------------------------------------------------"
