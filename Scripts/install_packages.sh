#!/usr/bin/env bash

packages=(
	fish
	fisher
	starship
	tmux
	exa
	rip
	nerd-fonts
	neovim
	npm
	lazygit
	redshift
	hub
	python-pip
	python-black
	fd
	grabc
	google-chrome
	brave
	discord
	spotify
)

for package in "${packages[@]}"; do
	sudo pacman -S "$package" --noconfirm
done
