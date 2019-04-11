#!/usr/bin/env bash

# Only run a program if it is not already running
function run {
    if ! pgrep $1 > /dev/null ;
    then
        $@&
    fi
}


run compton

run spotify

