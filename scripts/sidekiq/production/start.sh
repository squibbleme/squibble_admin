#!/bin/bash

echo -e "Start sidekiq [production]"

bundle exec sidekiq -d -C config/sidekiq/high.yml -e production;
bundle exec sidekiq -d -C config/sidekiq/low.yml -e production;

echo -e "\e[39m\e[32m \tDone"
