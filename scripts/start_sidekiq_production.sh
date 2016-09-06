#!/bin/bash

echo -e "Start sidekiq [production]"

bundle exec sidekiq -d -C config/sidekiq_high.yml -e production;
bundle exec sidekiq -d -C config/sidekiq_low.yml -e production;

echo -e "\e[39m\e[32m \tDone"
