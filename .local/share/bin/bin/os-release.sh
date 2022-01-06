#!/bin/sh

cat /etc/os-release | awk '/^ID=/ {print $1}' | sed 's/ID="//g' | sed 's/\"/ linux/g'
