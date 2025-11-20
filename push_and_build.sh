#!/usr/bin/env bash

sudo git add .
sudo git commit -m "$1"
sudo nixos-rebuild switch --flake /etc/nixos#bepithonk
