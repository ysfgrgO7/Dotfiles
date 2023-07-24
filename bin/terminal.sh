#!/bin/sh

env | awk '/^TERM=/ {print $1}' | sed 's/TERM=//g'
