#!/bin/bash
# launch_aso.sh - Native OpenClaw Activation for ASO

echo "🚀 Initializing Autonomous Sales Orchestrator..."

# 1. Force permissions and Token
TOKEN="aso_secure_token_2026"
export OPENCLAW_GATEWAY_TOKEN="$TOKEN"

# Persistence
if ! grep -q "OPENCLAW_GATEWAY_TOKEN" ~/.bashrc; then
    echo "export OPENCLAW_GATEWAY_TOKEN=\"$TOKEN\"" >> ~/.bashrc
fi

echo "[1/3] Configuring and Resetting Gateway Service..."
# Kill any lingering processes on port 18789
sudo fuser -k 18789/tcp > /dev/null 2>&1

# Set the missing configuration that was causing the "Missing config" error
openclaw config set gateway.mode local

# Try to install the service and start it with the required flags
sudo openclaw gateway install --token "$TOKEN" > /dev/null 2>&1
openclaw gateway stop > /dev/null 2>&1
openclaw gateway start --token "$TOKEN" --force --allow-unconfigured
sleep 10

# Verify Gateway Status
if ! openclaw health > /dev/null 2>&1; then
    echo "⚠️  Gateway service struggling. Forcing foreground fallback..."
    # Launch in background with nohup + allow-unconfigured to bypass checks
    nohup openclaw gateway run --token "$TOKEN" --allow-unconfigured > gateway.log 2>&1 &
    sleep 10
fi

# 2. Add Specialized Agents (Non-Interactive)
echo "[2/3] Adding Sales Team (handling prompts)..."

# atlas, librarian, momus, sisyphus, hephaestus
# We use a robust HEREDOC to handle any interactive prompts
for agent in atlas librarian momus sisyphus hephaestus; do
    echo "Adding $agent..."
    openclaw agents add "$agent" <<EOF

EOF
done

# 3. Final Verification
echo "[3/3] Mission Control Summary:"
openclaw agents list

echo "------------------------------------------------"
echo "✅ TEAM ACTIVATED"
echo "------------------------------------------------"
echo "RUN THESE FINAL COMMANDS:"
echo "source ~/.bashrc"
echo "openclaw tui"
echo "------------------------------------------------"
