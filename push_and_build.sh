#!/usr/bin/env bash

cd /etc/nixos/
sudo git add .
sudo git commit -m "$1"

