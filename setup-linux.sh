#!/bin/bash

log_color() {
	color_code="$1"
	shift

	printf "\033[${color_code}m%s\033[0m\n" "$*" >&2
}

log_red() {
	log_color "0;91" "$@"
}

log_blue() {
	log_color "0;96" "$@"
}

log_task() {
	log_blue "🔃" "$@"
}

log_error() {
	log_red "❌" "$@"
}

error() {
	log_error "$@"
	exit 1
}

cd "$HOME" || return
system_type=$(uname -s)

if [[ $system_type == "Linux" ]]; then
	printf "\n"
	log_blue "# HELLO LINUX USER! Setting up machine... #"

	printf "\n"
	log_task "Updating and upgrading"
	sudo apt update -y && sudo apt upgrade -y

	printf "\n"
	log_task "Installing git"
	sudo apt install -y git curl wget build-essential

	printf "\n"
	log_task "Installing homebrew"
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	printf '\neval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"\n' | tee -a ~/.profile
	source ~/.profile

	brew_packages=(
		"gcc"
		"chezmoi"
		"age"
	)
	for package in "${brew_packages[@]}"; do
		printf "\n"
		log_task "Installing $package"
		brew install "$package"
	done

	printf "\n"
fi
