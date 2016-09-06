#!/bin/bash

echo -e "Start sidekiq [development]"

bundle exec sidekiq -d -C config/sidekiq_high.yml;
bundle exec sidekiq -d -C config/sidekiq_low.yml;

echo -e "\e[39m\e[32m \tDone"
