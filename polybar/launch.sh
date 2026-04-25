#!/bin/sh
killall -q polybar

polybar audio &
polybar time &
polybar cpu &

