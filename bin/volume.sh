#!/bin/sh

amixer get Master | awk '{print $5}' | tail -n1 | sed -r 's/.*\[(.*)\].*/\1/'
