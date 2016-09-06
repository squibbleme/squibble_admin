#!/bin/bash

echo -e "Start unicorn [dev]"

bundle exec unicorn -c config/unicorn_development.rb -D --no-default-middleware;

echo -e "\e[39m\e[32m \tDone"
