#!/bin/bash

echo -e "Stop unicorn"

cat tmp/pids/unicorn.pid | xargs kill -9;

echo -e "\e[39m\e[32m \tDone"
