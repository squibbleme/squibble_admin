#!/bin/bash

echo -e "Start unicorn [dev]"

bundle exec unicorn -c config/unicorn/development.rb -D --no-default-middleware;

echo -e "\e[39m\e[32m \tDone"
