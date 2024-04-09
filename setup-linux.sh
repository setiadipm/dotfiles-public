#!/bin/bash

cd "$HOME" || return
system_type=$(uname -s)

if [[ $system_type == "Linux" ]]; then
	printf "\n\n# HELLO LINUX USER! #\n"

	printf "\n\n# Setting up machine... #\n"

	printf "    --> Updating and upgrading...\n"
	sudo apt update -qq -y && sudo apt upgrade -qq -y
	printf "    --> Installing git...\n"
	sudo apt install -qq -y git curl wget build-essential

	printf "    --> Installing homebrew...\n"
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" >/dev/null 2>&1
	printf '\neval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"\n' | tee -a ~/.profile >/dev/null
	source ~/.profile

	brew_packages=(
		"gcc"
		"chezmoi"
		"age"
	)
	for package in "${brew_packages[@]}"; do
		printf "    --> Installing $package...\n"
		brew install -q "$package" >/dev/null 2>&1
	done

	printf "\n"
fi
