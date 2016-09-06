#!/bin/bash

echo -e "Stop sidekiq"

cat tmp/pids/sidekiq_high.pid | xargs kill;
cat tmp/pids/sidekiq_low.pid | xargs kill;

echo -e "\e[39m\e[32m \tDone"
