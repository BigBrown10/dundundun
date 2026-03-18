# 1. Force permissions and Token
chmod +x "$0"
TOKEN="aso_secure_token_2026"
export OPENCLAW_GATEWAY_TOKEN="$TOKEN"

# Persistence
if ! grep -q "OPENCLAW_GATEWAY_TOKEN" ~/.bashrc; then
    echo "export OPENCLAW_GATEWAY_TOKEN=\"$TOKEN\"" >> ~/.bashrc
fi

echo "[1/3] Resetting Gateway Service..."
# Kill any lingering processes on port 18789
sudo fuser -k 18789/tcp > /dev/null 2>&1

# Stop and Force Start Gateway
openclaw gateway stop > /dev/null 2>&1
openclaw gateway start --token "$TOKEN" --force
sleep 10

# Verify Gateway Status
if ! openclaw health > /dev/null 2>&1; then
    echo "⚠️  Gateway background service failed. Starting in foreground fallback..."
    # Launch in background with nohup to keep it alive
    nohup openclaw gateway run --token "$TOKEN" > gateway.log 2>&1 &
    sleep 10
fi

# 2. Add Specialized Agents (Non-Interactive)
echo "[2/3] Adding Sales Team (handling prompts)..."

# atlas, librarian, momus, sisyphus, hephaestus
# We use echo "" to accept the default workspace path in the prompt
for agent in atlas librarian momus sisyphus hephaestus; do
    echo "Adding $agent..."
    echo "" | openclaw agents add $agent > /dev/null 2>&1
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
