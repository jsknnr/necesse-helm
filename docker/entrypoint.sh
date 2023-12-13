#!/bin/bash
# Set server config path
SERVER_CONFIG=/home/steam/.config/Necesse/cfg/server.cfg

# Update/install Necesse
"$STEAMCMD_PATH"/steamcmd.sh +force_install_dir "$NECESSE_PATH" +login anonymous +app_update 1169370 validate +quit

#Check required arguments
if [ -z "$WORLD_NAME" ]; then
    echo "ERROR: WORLD_NAME not set"
    exit 1
fi

if [ -z "$GAME_PORT" ]; then
    echo "ERROR: GAME_PORT net set"
    exit 1
fi

# Update server configuration
sed -i "s/port = [0-9]\+/port = $GAME_PORT/" "$SERVER_CONFIG"

if [ -n "$SERVER_SLOTS" ]; then
    sed -i "s/slots = [0-9]\+/slots = $SERVER_SLOTS/" "$SERVER_CONFIG"
fi

if [ -n "$SERVER_PASSWORD" ]; then
    sed -i "s/password = \".*\"/password = $SERVER_PASSWORD/" "$SERVER_CONFIG"

if [ -n "$PAUSE_EMPTY" ]; then
    sed -i "s/pauseWhenEmpty = .*$/pauseWhenEmpty = $PAUSE_EMPTY,/" "$SERVER_CONFIG"
fi

if [ -n "$MAX_LATENCY" ]; then
    sed -i "s/maxClientLatencySeconds = [0-9]\+/maxClientLatencySeconds = $MAX_LATENCY/" "$SERVER_CONFIG"
fi

if [ -n "$CLIENT_POWER "]; then
    sed -i "s/giveClientsPower = .*$/giveClientsPower = $CLIENT_POWER,/" "$SERVER_CONFIG"
fi

if [ -n "$LANGUAGE" ]; then
    sed -i "s/language = .*/language = $LANGUAGE,/" "$SERVER_CONFIG"
fi

if [ -n "$MOTD" ]; then
    sed -i "s/MOTD = .*$/MOTD = \"$MOTD\"/" "$SERVER_CONFIG"
fi

# Launch Necesse server
java -jar "$NECESSE_PATH"/Server.jar -nogui -world "$WORLD_NAME"
