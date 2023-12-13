#!/bin/bash
# Update/install Necesse
"$STEAMCMD_PATH"/steamcmd.sh +force_install_dir "$NECESSE_PATH" +login anonymous +app_update 1169370 validate +quit

# Build launch arguments
LAUNCH_ARGS=""
if [ -z "$WORLD_NAME" ]; then
    echo "ERROR: WORLD_NAME not set"
    exit 1
else
    LAUNCH_ARGS="${LAUNCH_ARGS} -world ${WORLD_NAME}"
fi  

if [ -z "$GAME_PORT" ]; then
    echo "ERROR: GAME_PORT net set"
    exit 1
else
    LAUNCH_ARGS="${LAUNCH_ARGS} -port ${GAME_PORT}"
fi

if [ -z "$SERVER_PASSWORD" ]; then
    echo "WARN: SERVER_PASSWORD not set, server will not require a password to join"
else
    LAUNCH_ARGS="${LAUNCH_ARGS} -password ${SERVER_PASSWORD}"
fi

if [ -n "$SERVER_SLOTS" ]; then
    LAUNCH_ARGS="${LAUNCH_ARGS} -slots ${SERVER_SLOTS}"
fi

if [ -n "$PAUSE_EMPTY" ]; then
    LAUNCH_ARGS="${LAUNCH_ARGS} -pausewhenempty ${PAUSE_EMPTY}"
fi

if [ -n "$MAX_LATENCY" ]; then
    LAUNCH_ARGS="${LAUNCH_ARGS} -maxclientlatencyseconds ${MAX_LATENCY}"
fi

if [ -n "$CLIENT_POWER" ]; then
    LAUNCH_ARGS="${LAUNCH_ARGS} -giveclientspower ${CLIENT_POWER}"
fi

if [ -n "$LANGUAGE" ]; then
    LAUNCH_ARGS="${LAUNCH_ARGS} -language ${LANGUAGE}"
fi

if [ -n "$MOTD" ]; then
    LAUNCH_ARGS="${LAUNCH_ARGS} -motd ${MOTD}"
fi

if [ -n "$LOGGING" ]; then
    LAUNCH_ARGS="${LAUNCH_ARGS} -logging ${LOGGING}"
fi

if [ -n "$ZIP_SAVES" ]; then
    LAUNCH_ARGS="${LAUNCH_ARGS} -zipsaves ${ZIP_SAVES}"
fi

# Launch Necesse server
java "$JVM_ARGS" \ 
  -jar "$NECESSE_PATH"/Server.jar \
  -nogui \
  "${LAUNCH_ARGS}"
