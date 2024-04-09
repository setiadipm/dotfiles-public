## Overview

This repository contains all my dotfiles managed by [chezmoi](https://github.com/twpayne/chezmoi). I use this dotfiles to manage my Windows 11 machine and WSL Ubuntu.

Each machine has its own prerequisite commands to run, therefore I separated those commands into a file called `setup` followed by the machine name. This command must be executed before starting the setup using chezmoi.

## Machine Setup

### Github Personal Access Token

***Do the following if you don't have a token yet***

1. Login to [Github](https://github.com)
2. Settings &rarr; Developer Settings &rarr; Personal access tokens &rarr; Fine-grained tokens  
3. Delete previous token named `run-dotfiles` *(optional)*
4. Generate new token
5. Set token name: `run-dotfiles`
6. Set expiration: 1 year from current date
4. Set repository access: `Only select repositories` &rarr; `setiadipm/dotfiles`  
5. Set repository permissions `contents` &rarr; `Read-only`
6. Generate token

### Configure SSH Key

1. Initiate SSH key  
   Run the following command will create `.ssh` directory in your user directory (`C:\Users\User` or `/home/user`)
   ```sh
   ssh-keygen -t rsa -b 4096
   ```
2. Copy files `id_rsa` and `id_rsa.pub` from `D:\PyZzZ\Configs\Git SSH` to the directory  
   This key has been registered in Github and Gitlab

### Windows

Run **Powershell** as **Administrator**

Replace the **`GITHUB_TOKEN`** accordingly

```powershell
Set-ExecutionPolicy Bypass -Scope CurrentUser; Set-Location $env:USERPROFILE; Invoke-WebRequest -Headers @{ Authorization = "token GITHUB_TOKEN" } -Uri "https://raw.githubusercontent.com/setiadipm/dotfiles/main/setup-windows.ps1" | Invoke-Expression
```

```powershell
Set-ExecutionPolicy ByPass -Scope CurrentUser; chezmoi init --apply git@github.com:setiadipm/dotfiles.git
```

### Windows Subsystem for Linux (WSL)

Replace the **`GITHUB_TOKEN`** accordingly

```sh
curl -sSH "Authorization: token GITHUB_TOKEN" "https://raw.githubusercontent.com/setiadipm/dotfiles/main/setup-linux.sh" | bash
```

```sh
source .profile && chezmoi init --apply git@github.com:setiadipm/dotfiles.git
```

## Todo After Machine Setup

### Manual Installation

- Visual Studio Community 2022
  ```sh
  choco install visualstudio2022community
  ```
- DevExpress
- Microsoft Office
- WhatsApp
- Zoom
- Microsoft Teams
- Install Apache
  ```sh
  D:\Apache24\bin\httpd -k install
  ```
- Install MySQL
  ```sh
  D:\Apache24\mysql5\bin\mysqld install
  D:\Apache24\mysql8\bin\mysqld install
  ```

### Desktop Configuration

- Setup Desktop
  - Pin app to Start
  - Pin app to Taskbar
  - Add and place Widget with `BeWidgets`
  - Setup Taskbar theme with `TranslucentTB`
- Setup Personal folders (Desktop, Downloads, Documents, Picture, etc) to D: directory
- Import VPN profiles
- Setup explorer window size
- Setup browser
- Import Cyberduck bookmarks
- Import DBeaver configurations
- Login Postman
- Setup WSL

### Setup WSL

1. Install Ubuntu distro  

   Install from Microsoft Store
   ```sh
   $ wsl --install -d Ubuntu-22.04
   ```
   **OR**  

   Install from [Ubuntu Cloud Images](https://cloud-images.ubuntu.com/) | [Jammy Jellyfish 22.04 LTS](https://cloud-images.ubuntu.com/wsl/jammy/current/ubuntu-jammy-wsl-amd64-wsl.rootfs.tar.gz)
   ```sh
   $ wsl --install --no-distribution
   $ wsl --set-default-version 2
   $ wsl --update
   $ wsl --import Ubuntu-22.04 D:\WSL\Ubuntu\ D:\WSL\ubuntu-jammy-wsl-rootfs.tar.gz
   $ wsl -d Ubuntu-22.04
   ```
   **OR**

   Install from backup file  
   ***No need to follow the rest of the steps***
   ```sh
   $ wsl --import Ubuntu-22.04 D:\WSL\Ubuntu\ D:\WSL\ubuntu-jammy-wsl-rootfs.tar.gz
   $ wsl -d Ubuntu-22.04
   ```

2. Setup default username and WSL config  

   Replace the **`LINUX_USERNAME`** accordingly
   ```sh
   $ NEW_USER=LINUX_USERNAME
   $ useradd -m -G sudo -s /bin/bash "$NEW_USER"
   $ passwd "$NEW_USER"
   ```
   ```sh
   $ sudo tee /etc/wsl.conf <<_EOF
   [user]
   default = ${NEW_USER}

   [interop]
   appendWindowsPath = false

   [boot]
   command = "service apache2 start"
   _EOF
   $ exit
   ```
3. Disable sudo for auto replacing `/etc/hosts` file  

   Replace the **`LINUX_USERNAME`** accordingly
   ```sh
   $ sudo tee /etc/sudoers.d/hosts <<_EOF
   LINUX_USERNAME ALL=(ALL:ALL) NOPASSWD: /usr/bin/sed -i */host.docker.internal/d /etc/hosts, /usr/bin/sed -i */gateway.docker.internal/d /etc/hosts, /usr/bin/tee -a /etc/hosts
   _EOF
   ```

4. Rerun Ubuntu
   ```sh
   $ wsl --terminate Ubuntu-22.04
   $ wsl -d Ubuntu-22.04
   ```

### Setup Apache on WSL

1. Setup config

   ```sh
   $ sudo vim /etc/apache2/sites-available/000-default.conf
   
   ...
   ServerAdmin webmaster@localhost
   DocumentRoot /var/www/html

   <Directory /var/www/>
      Options Indexes FollowSymlinks
      AllowOverride All
      Require all granted
   </Directory>
   ...
   
   ...
   LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %Ts %Dμs" customformat

   ErrorLog ${APACHE_LOG_DIR}/error.log
   CustomLog ${APACHE_LOG_DIR}/access.log customformat
   ...
   ```

2. Change apache run user  

   Replace the **`LINUX_USERNAME`** accordingly
   ```sh
   $ sudo vim /etc/apache2/envvars
   
   ...
   export APACHE_RUN_USER=LINUX_USERNAME
   export APACHE_RUN_GROUP=LINUX_USERNAME
   ...
   ```

3. Clean existing sessions

   ```sh
   $ sudo su
   $ rm /var/lib/php/sessions/*
   ```

4. Restart apache

   ```sh
   $ sudo service apache2 restart
   ```

## Chezmoi Commands

### Daily Operations

- `chezmoi add $FILE` adds `$FILE` from your home directory to the source directory.
- `chezmoi add --template $FILE` adds `$FILE` as a template.
- `chezmoi add --encrypt $FILE` adds `$FILE` to be encrypted.
- `chezmoi re-add $FILE` modifies file in the target state, preserving any `encrypted_` attributes.
- `chezmoi status` gives a quick summary of what files would change if you ran `chezmoi apply`.
- `chezmoi diff` shows the changes that `chezmoi apply` would make to your home directory.
- `chezmoi apply` updates your dotfiles from the source directory.
- `chezmoi update` pulls the latest changes from your remote repo and runs `chezmoi apply`.
- `chezmoi init --apply --verbose $GIT_URL` combines the init and apply command.

### Encryption

#### Install age

[age](https://github.com/FiloSottile/age) is a simple, modern, and secure file encryption tool, format, and Go library.

| **Tools / OS**   | **Command**                                  |
| ---------------- | -------------------------------------------- |
| Homebrew (Linux) | `brew install age`                           |
| Debian / Ubuntu  | `apt install age`                            |
| Scoop (Windows)  | `scoop bucket add extras; scoop install age` |

#### Generate an age private key

Generate the private key with a passphrase in the file `key.txt.age` with the command:

```sh
chezmoi cd && age-keygen | age --armor --passphrase > key.txt.age
```

```sh
Public key: age193wd0hfuhtjfsunlq3c83s8m93pde442dkcn7lmj3lspeekm9g7stwutrl
Enter passphrase (leave empty to autogenerate a secure one):
Confirm passphrase:
```

Add `key.txt.age` to `.chezmoiignore` so that chezmoi does not try to create it:

```sh
echo key.txt.age >> .chezmoiignore
```

Configure chezmoi to use the public and private key for encryption.
`age.recipient` must be the public key generated on `age-keygen` command above.

```sh
cat >> .chezmoi.toml.tmpl <<EOF
encryption = "age"
[age]
	identity = "~/.config/chezmoi/key.txt"
	recipient = "age193wd0hfuhtjfsunlq3c83s8m93pde442dkcn7lmj3lspeekm9g7stwutrl"
EOF
```

## Todo Before Format

- Backup WSL
  ```sh
  wsl --export Ubuntu-22.04 D:\WSL\Ubuntu-22.04.tar
  ```
- Export DBeaver configurations  
  File &rarr; Export
  - DBeaver project
  - DBeaver preferences
  - General preferences
- Export Cyberduck bookmarks  
  Drag and drop from Cyberduck bookmarks list to Explorer  
  Location: `D:\PyZzZ\Configs\Cyberduck`
- Backup Brave User Data  
  Copy `User Data` directory in `$SCOOP\persist\brave\User Data` to `D:\PyZzZ\Configs\Brave`
