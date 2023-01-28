#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "No jar file provided"
    exit 1
fi

jar_file=$1

screen -dmS minecraft_production java -Xms16384M -Xmx16384M -XX:+UseCompressedOops -XX:+UseStringDeduplication -XX:+OptimizeStringConcat -XX:+HeapDumpOnOutOfMemoryError -Dterminal.jline=false -Dterminal.ansi=true -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -jar $jar_file nogui
