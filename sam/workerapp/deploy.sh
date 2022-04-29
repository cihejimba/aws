#!/bin/sh

bundle install
#bundle lock --add-platform ruby
eb deploy
