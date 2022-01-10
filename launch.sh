#!/bin/sh
cd "$(dirname "$(readlink -fn "$0")")"
tmux new-session -d -s mc_session 'java -Xms6G -Xmx8G -jar mohist-server.jar'
