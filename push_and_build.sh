#!/usr/bin/env bash

git add .
git commit -m "$1"

wget -q --spider http://google.com
if [$? -eq 0 ]; then
	git push
else
	echo "Not pushed, offline"
fi
sudo nixos-rebuild switch --flake /etc/nixos#bepithonk
