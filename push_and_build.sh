#!/usr/bin/env bash

git add .
git commit -m "$1"
git push

sudo nixos-rebuild switch --flake /etc/nixos#bepithonk
