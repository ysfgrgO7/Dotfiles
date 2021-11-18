#!/bin/sh

env | awk '/^SHELL=/ {print $1}' | sed 's/SHELL=//g' | sed -e 's/bin//g' | sed -e 's/\///g'
