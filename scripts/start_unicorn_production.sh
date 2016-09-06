#!/bin/bash

echo -e "Start unicorn [production]"

bundle exec unicorn -c config/unicorn_production.rb -E production -D --no-default-middleware;

echo -e "\e[39m\e[32m \tDone"
