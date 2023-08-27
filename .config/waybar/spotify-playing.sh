#!/bin/sh

playerctl --player spotify metadata --format "{{ title }} - {{ artist }}"

