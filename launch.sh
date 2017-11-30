#!/bin/bash

set -e

gameport=`expr 27960 + $1`
rconport=`expr 28960 + $1`
servernum=`expr 1 + $1`

echo "servernum=$servernum"
echo "gameport=$gameport"
echo "rconport=$rconport"

if [ -n "$GAME_PASSWORD" ]; then
    GAME_PASSWORD_ARGS="+set g_needpass 1 +set g_password $GAME_PASSWORD"
fi

if [ -n "$RCON_PASSWORD" ]; then
    RCON_PASSWORD_ARGS="+set zmq_rcon_enable 1 +set zmq_rcon_port $rconport +set zmq_rcon_password \"$RCON_PASSWORD\""
fi

if [ -n "$ZMQ_PASSWORD" ]; then
    ZMQ_PASSWORD_ARGS="+set zmq_stats_enable 1 +set zmq_stats_port $gameport +set zmq_stats_password \"$ZMQ_PASSWORD\""
fi

exec /home/steam/Steam/steamapps/common/qlds/run_server_x64.sh \
+set net_strict 1 \
+set net_port $gameport \
+set sv_hostname "Cyprus (primarily FFA) #$servernum" \
+set fs_homepath "/home/steam/.quakelive" \
+set sv_mapPoolFile "mappool.txt" \
+set g_accessFile "access.txt" \
+set sv_serverType 2 \
+set sv_master 1 \
+set sv_tags cyprus,wargaming \
+set timelimit 10 \
$GAME_PASSWORD_ARGS \
$RCON_PASSWORD_ARGS \
$ZMQ_PASSWORD_ARGS
